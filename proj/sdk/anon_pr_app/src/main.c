/*
 * This is a project in which Dynamic Partial Reconfiguration can be carried out with just a click of SW5 on the board
 *
 * Basic Concept: A prototype design and program for a self-adaptive system
 *
 * once you replace the input signal from SW5 with some kind of a flag signal with which you would like to control DPR,
 * DPR will be triggered with the signal
 *
 */

/* Include any headers necessary for the system */
#include "xparameters.h"
#include "xil_printf.h"
#include "xaxidma.h"
#include "xil_cache.h"
#include "xdevcfg.h"
#include "ff.h"
#include "stdlib.h"
#include "xgpiops.h"
#include "xtime_l.h"
#include "xadcps.h"

/* Setting up for AXI DMA */
volatile unsigned int* axi_dma     = XPAR_AXI_DMA_0_BASEADDR;
volatile unsigned int* axi_pr_decouple = XPAR_AXI_PR_DECOUPLE_BASEADDR;

/* The number of DATA in a data set */
#define DATA_NUM 32

/* Setting up for data transaction from SD to DDR */
static FATFS fatfs;
static FIL fil;
FRESULT result;
static char buffer[128];	// name of the log
static char *boot_file; 	// pointer to the log
TCHAR *path = "0:/"; 		// Logical drive number is 0

/* Setting up for Device Configuration */
XDcfg *XDcfg_0;
XDcfg_Config *ConfigPtr;
XGpioPs_Config *GpioConfigPtr;

/* Setting up for Xilinx GPIO PS */
static XGpioPs psGpioInstancePtr;
extern XGpioPs_Config XGpioPs_ConfigTable[XPAR_XGPIOPS_NUM_INSTANCES];
int iPinNumberEMIO = 54;
u32 uPinDirectionEMIO = 0x0;

/* Setting up for Xilinx ADC */
XAdcPs XAdcPs_0;
XAdcPs_Config *XAdcPs_ConfigPtr;

/* ALL THE INFO ABOUT DYNAMIC PARTIAL RECONFIGURATION WITH PCAP(Processor Configuration Access Port) */
#define BITFILE_LEN								0x00033148 //209,224bytes = 210KBytes
#define MASK_PARTIAL_BITSTREAM_SOURCE_ADDR 		0x00140000
#define NOISE_PARTIAL_BITSTREAM_SOURCE_ADDR 	0x00180000
#define SWAP_PARTIAL_BITSTREAM_SOURCE_ADDR 		0x001c0000
#define MICRO_PARTIAL_BITSTREAM_SOURCE_ADDR 	0x00200000

volatile unsigned int *test_data   = 0x10100000;
volatile unsigned int *masked_data = 0x10200000;
volatile unsigned int *noised_data = 0x10300000;
volatile unsigned int *microed_data = 0x10400000;
volatile unsigned int *swapped_data = 0x10500000;

/*
* Device Configuration Initialization
*
* Arguments
* 1. u16 DeviceId: ID for the device configuration
*
*/
XDcfg *XDcfg_Initialize(u16 DeviceId)
{
	/* 'Status' for checking if the func works correctly */
	int Status;

	/* Setting up and initialize Device Configuration Port */
	XDcfg *Instance = malloc(sizeof *Instance);
	XDcfg_Config *Config = XDcfg_LookupConfig(DeviceId);
	Status = XDcfg_CfgInitialize(Instance, Config, Config->BaseAddr);
	if (Status != XST_SUCCESS) return NULL;
	XDcfg_SetLockRegister(Instance, XDCFG_UNLOCK_DATA);

	/* Enable and select PCAP interface for partial reconfiguration */
	XDcfg_EnablePCAP(Instance);

	/* Setting control register for PCAP mode */
	XDcfg_SetControlRegister(Instance, XDCFG_CTRL_PCAP_MODE_MASK | XDCFG_CTRL_PCAP_PR_MASK);

	xil_printf("DevConfig Init Done!!\r\n");

	return Instance;
}

/*
* Transfer partial bitstream file from DDR to PL
*
* Arguments
* 1. XDcfg *Instance: instance pointer
* 2. u32 StartAddress: the start address of the partial bitstream file
* 3. u32 WordLength: the word length of the file to be transferred (1 word = 4 bytes = 32bits)
*
*/
int XDcfg_TransferBitfile(XDcfg *Instance, u32 StartAddress, u32 WordLength)
{
	int Status;
	volatile u32 IntrStsReg = 0;
	XTime tStart, tEnd;

	/* Setup the Global time counter */
	XTime_GetTime(&tStart);

	/* decouple the Reconfigurable Region */
	axi_pr_decouple[0] = 0x0;

	/* Clear DMA and PCAP Done Interrupts */
	XDcfg_IntrClear(Instance, (XDCFG_IXR_DMA_DONE_MASK | XDCFG_IXR_D_P_DONE_MASK));

	/* Transfer bitstream from DDR into fabric in non secure mode */
	//Status = XDcfg_Transfer(Instance, (u32 *) StartAddress, WordLength, (u32 *) XDCFG_DMA_INVALID_ADDRESS, 0, XDCFG_NON_SECURE_PCAP_WRITE);
	Status = XDcfg_Transfer(Instance, (u32 *) StartAddress, WordLength, (u32 *) XDCFG_DMA_INVALID_ADDRESS, 0, XDCFG_SECURE_PCAP_WRITE);
	if (Status != XST_SUCCESS)
		return Status;

	// Poll DMA Done Interrupt
	while ((IntrStsReg & XDCFG_IXR_DMA_DONE_MASK) != XDCFG_IXR_DMA_DONE_MASK)
		IntrStsReg = XDcfg_IntrGetStatus(Instance);

	// Poll PCAP Done Interrupt
	while ((IntrStsReg & XDCFG_IXR_D_P_DONE_MASK) != XDCFG_IXR_D_P_DONE_MASK)
		IntrStsReg = XDcfg_IntrGetStatus(Instance);

	/* Disable decoupling */
	axi_pr_decouple[0] = 0x1;

	/* Get the time */
	XTime_GetTime(&tEnd);

	printf("The Start time: %llu\r\n", tStart);
	printf("The End time: %llu\r\n", tEnd);

	u64 diff = tEnd - tStart;
	float cps = (float)COUNTS_PER_SECOND/1000000.0;
	float difftime = 1.0 * diff/cps;

	printf("***********************************\r\n");
	printf("cps: %8.2f, The Reconfiguration time: %llu clock cycles = %8.2f us\r\n", cps, diff, difftime);
	printf("***********************************\r\n");

	xil_printf("Load to PL Done!!\r\n");

	return XST_SUCCESS;
}

char *strcpy_rom(char *Dest, const char *Src)
{
    unsigned i;
    for (i=0; Src[i] != '\0'; ++i)
        Dest[i] = Src[i];
    	Dest[i] = '\0';
    return Dest;
}

/*
* Transfer partial bitstream file from SD to DDR
*
* Arguments
* 1. const char *filename: the name of a file to be transferred
* 2. u32 DestinationAddress: destination address where the transferred file will be stored 
*
*/
u32 TransferDataFromSD(const char *filename, u32 DestinationAddress)
{

	/*
	 * Register volume work area, initialize device
	 * correlate SD card to the pointer &fatfs
	 */

	strcpy_rom(buffer, filename);
	boot_file = (char *)buffer;

	/* &fil correlated to the file name in READ mode */
	result = f_open(&fil, boot_file, FA_READ);
	if (result) {
		xil_printf(" ERROR : f_open returned %d\r\n", result);
		return XST_FAILURE;
	}

	result = f_lseek(&fil, 0);
	if (result) {
		xil_printf(" ERROR : f_lseek returned %d\r\n", result);
		return XST_FAILURE;
	}

	unsigned int BytesRd;
	result = f_read(&fil, (void*)DestinationAddress, BITFILE_LEN, &BytesRd);

	if (result) {
		xil_printf(" ERROR : f_read returned %d\r\n", result);
		return XST_FAILURE;
	}

	xil_printf("SD to DDR Done!!\r\n");

	f_close(&fil);

	return XST_SUCCESS;
}

int main()
{

  xil_printf("Hello!!\n\r\n\r");
  Xil_DCacheDisable();

  int i, Status;
  static int count = 0;
  static int Readstatus = 0, OldReadStatus = 0;

  /* Initialize the DevConfig down here */
  XDcfg_0 = XDcfg_Initialize(XPAR_PS7_DEV_CFG_0_DEVICE_ID);
  if (XDcfg_0 == NULL) return XST_FAILURE;

  /* Initialize the GPIO PS */
  GpioConfigPtr = XGpioPs_LookupConfig(XPAR_PS7_GPIO_0_DEVICE_ID);
  if(GpioConfigPtr == NULL) return XST_FAILURE;
  Status = XGpioPs_CfgInitialize(&psGpioInstancePtr,GpioConfigPtr, GpioConfigPtr->BaseAddr);
  if(XST_SUCCESS != Status) print(" PS GPIO INIT FAILED \n\r");

  /* Setting up EMIO PIN as Input port */
  XGpioPs_SetDirectionPin(&psGpioInstancePtr,iPinNumberEMIO,uPinDirectionEMIO);
  XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, iPinNumberEMIO,0);

  xil_printf("around here?\r\n");

  /* Initialize the XADC */
  XAdcPs_ConfigPtr = XAdcPs_LookupConfig(XPAR_PS7_XADC_0_DEVICE_ID);
  if(XAdcPs_ConfigPtr == NULL) return XST_FAILURE;
  Status = XAdcPs_CfgInitialize(&XAdcPs_0, XAdcPs_ConfigPtr, XAdcPs_ConfigPtr->BaseAddress);
  if(XST_SUCCESS != Status) print(" XADC INIT FAILED \n\r");

  xil_printf("or maybe here?\r\n");

  /*
   * Partial BIN File transaction down here
   * BIN File from the SD card to DDR
   */
  result = f_mount(&fatfs, path, 0);
  xil_printf("result = %d\r\n", result);
  if (result != FR_OK) {
  	xil_printf(" ERROR : f_mount returned %d\r\n", result);
  	return XST_FAILURE;
  }
  Status = TransferDataFromSD("map.bin", MASK_PARTIAL_BITSTREAM_SOURCE_ADDR);
  if (Status != XST_SUCCESS) {
    	return XST_FAILURE;
  }
  Status = TransferDataFromSD("np.bin", NOISE_PARTIAL_BITSTREAM_SOURCE_ADDR);
  if (Status != XST_SUCCESS) {
    	return XST_FAILURE;
  }
  Status = TransferDataFromSD("swap.bin", SWAP_PARTIAL_BITSTREAM_SOURCE_ADDR);
  if (Status != XST_SUCCESS) {
      	return XST_FAILURE;
  }
  Status = TransferDataFromSD("mip.bin", MICRO_PARTIAL_BITSTREAM_SOURCE_ADDR);
  if (Status != XST_SUCCESS) {
       	return XST_FAILURE;
  }

  /* Generate Sample Data */
  for (i = 0; i < DATA_NUM; i++) {
    test_data[i] = (i + 31) * (i + 44);
  }

  xil_printf("Off we go, buddies!!\n\r\n\r");

  /* Disable decoupling */
  axi_pr_decouple[0] = 0x1;

  /*
   * HERE IS THE MAIN PROCESS!!
   */
  while(count < 10) {
	/*
	 * See if the SW5 is being pushed
	 * 0: not pushed, 1: pushed
	 */
	Readstatus = XGpioPs_ReadPin(&psGpioInstancePtr, iPinNumberEMIO);

	/*
	 * Measuring the on-chip temperature and VCCINT using XADC
	 */
	float oc_temp = (XAdcPs_GetAdcData(&XAdcPs_0, XADCPS_CH_TEMP) >> 4)*503.975/4096.0 - 273.15;
	float oc_vcc  = (XAdcPs_GetAdcData(&XAdcPs_0, XADCPS_CH_VCCINT) >> 4)/4096.0*3.0;

	printf("On-chip temperature: %.2f ℃\r\n", oc_temp);
	printf("On-chip vccint(volt): %.2f V\r\n", oc_vcc);

   	if(1 == Readstatus && 0 == OldReadStatus ) {
   		count++;
   		if (count % 4 == 0) {
   			/* Transfer MASK Bitstream using DEVCFG/PCAP */
   			Status = XDcfg_TransferBitfile(XDcfg_0, MASK_PARTIAL_BITSTREAM_SOURCE_ADDR, (BITFILE_LEN >> 2));
   			if (Status != XST_SUCCESS) {
   				xil_printf("ERROR : FPGA configuration failed!\n\r\n\r");
   				exit(EXIT_FAILURE);
   			}
   		} else if (count % 4 == 1) {
			/* Transfer NOISE Bitstream using DEVCFG/PCAP */
   			Status = XDcfg_TransferBitfile(XDcfg_0, NOISE_PARTIAL_BITSTREAM_SOURCE_ADDR, (BITFILE_LEN >> 2));
			if (Status != XST_SUCCESS) {
				xil_printf("ERROR : FPGA configuration failed!\n\r\n\r");
				exit(EXIT_FAILURE);
			}
   		} else if (count % 4 == 2) {
			/* Transfer SWAP Bitstream using DEVCFG/PCAP */
			Status = XDcfg_TransferBitfile(XDcfg_0, SWAP_PARTIAL_BITSTREAM_SOURCE_ADDR, (BITFILE_LEN >> 2));
			if (Status != XST_SUCCESS) {
				xil_printf("ERROR : FPGA configuration failed!\n\r\n\r");
				exit(EXIT_FAILURE);
			}
   		} else {
			/* Transfer MICRO Bitstream using DEVCFG/PCAP */
			Status = XDcfg_TransferBitfile(XDcfg_0, MICRO_PARTIAL_BITSTREAM_SOURCE_ADDR, (BITFILE_LEN >> 2));
			if (Status != XST_SUCCESS) {
				xil_printf("ERROR : FPGA configuration failed!\n\r\n\r");
				exit(EXIT_FAILURE);
			}
   		}
   	} else {
   		if (count % 4 == 0) {
			/* Kick MM2S transfer */
			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_SRCADDR_OFFSET) >> 2] = test_data;
			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

			/* Kick S2MM transfer */
			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_DESTADDR_OFFSET) >> 2] = masked_data;
			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

			while (1){
				if ((axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET) >> 2] & 0x2) != 0x0) break;
			}

			for(i=0; i<DATA_NUM; i++) xil_printf("test_data[%d] = %d, masked_data[%d] = %d\n\r", i, test_data[i], i, masked_data[i]);


   		} else if (count % 4 == 1) {
   			/* Kick MM2S transfer */
   			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
   			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_SRCADDR_OFFSET) >> 2] = test_data;
   			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

			/* Kick S2MM transfer */
   			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
   			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_DESTADDR_OFFSET) >> 2] = noised_data;
   			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

   			while (1){
   				if ((axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET) >> 2] & 0x2) != 0x0) break;
   			}

   			for(i=0; i<DATA_NUM; i++) xil_printf("test_data[%d] = %d, noised_data[%d] = %d\n\r", i, test_data[i], i, noised_data[i]);

   		} else if (count % 4 == 2) {
   			/* Kick MM2S transfer */
   			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
   			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_SRCADDR_OFFSET) >> 2] = test_data;
   			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

   			/* Kick S2MM transfer */
   			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
   			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_DESTADDR_OFFSET) >> 2] = swapped_data;
   			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

   			while (1){
   				if ((axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET) >> 2] & 0x2) != 0x0) break;
   			}

   			for(i=0; i<DATA_NUM; i++) xil_printf("test_data[%d] = %d, swapped_data[%d] = %d\n\r", i, test_data[i], i, swapped_data[i]);

   		} else {
   			/* Kick MM2S transfer */
   			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
   			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_SRCADDR_OFFSET) >> 2] = test_data;
   			axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

   			/* Kick S2MM transfer */
   			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
   			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_DESTADDR_OFFSET) >> 2] = microed_data;
   			axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

   			while (1){
   				if ((axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET) >> 2] & 0x2) != 0x0) break;
   			}

   			for(i=0; i<DATA_NUM; i++) xil_printf("test_data[%d] = %d, microed_data[%d] = %d\n\r", i, test_data[i], i, microed_data[i]);

   		}
   	}
   	OldReadStatus = Readstatus;
  }


  xil_printf("Everything is Done!\n\r");

  return 0;
}
