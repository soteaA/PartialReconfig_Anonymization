/*
 * Include any headers necessary for the system
 */


#include "xparameters.h"
#include "xil_printf.h"
#include "xaxidma.h"
#include "xil_cache.h"
#include "xdevcfg.h"
#include "ff.h"
#include "stdlib.h"

// Setting up for AXI DMA
volatile unsigned int* axi_dma     = XPAR_AXI_DMA_0_BASEADDR;
volatile unsigned int* axi_pr_ctrl = XPAR_AXI_PR_CTRL_BASEADDR;

//The number of DATA in a data set
#define DATA_NUM 32

/*
 * Setting up for data transaction from SD to DDR
 */
static FATFS fatfs;
static FIL fil;
FRESULT result;
static char buffer[128]; // name of the log
static char *boot_file; // pointer to the log
TCHAR *path = "0:/"; /* Logical drive number is 0 */
unsigned int BytesRd;


/*
 * Setting up for Device Configuration
 */
XDcfg *XDcfg_0;
XDcfg_Config *ConfigPtr;

//ALL THE INFO ABOUT DYNAMIC PARTIAL RECONFIGURATION WITH PCAP(Processor Configuration Access Port)
#define BITFILE_LEN								0x0004EE50
#define CONFIG_SIZE								0x00800000
#define MASK_PARTIAL_BITSTREAM_SOURCE_ADDR 		0x00000000
#define NOISE_PARTIAL_BITSTREAM_SOURCE_ADDR 	0x00200000
#define SWAP_PARTIAL_BITSTREAM_SOURCE_ADDR 		0x00277298
#define MICRO_AGG_PARTIAL_BITSTREAM_SOURCE_ADDR 0x003B2BE4

volatile unsigned int *config_lib = 0x00000000;
volatile unsigned int *test_data = 0x01000000;
volatile unsigned int *result_data    = 0x02000000;

//XDcfg *XDcfg_Initialize(u16 DeviceId)
XDcfg *XDcfg_Initialize(u16 DeviceId)
{
	int Status;

	XDcfg *Instance = malloc(sizeof *Instance);
	XDcfg_Config *Config = XDcfg_LookupConfig(DeviceId);
	Status = XDcfg_CfgInitialize(Instance, Config, Config->BaseAddr);
	if (Status != XST_SUCCESS) return NULL;
	XDcfg_SetLockRegister(Instance, XDCFG_UNLOCK_DATA);

	// Enable and select PCAP interface for partial reconfiguration
	XDcfg_EnablePCAP(Instance);

	//Setting control register for PCAP mode
	XDcfg_SetControlRegister(Instance, XDCFG_CTRL_PCAP_MODE_MASK | XDCFG_CTRL_PCAP_PR_MASK);

	xil_printf("DevConfig Init Done!!\r\n");

	return Instance;
}

int XDcfg_TransferBitfile(XDcfg *Instance, u32 StartAddress, u32 WordLength)
{
	int Status;
	volatile u32 IntrStsReg = 0;

	/*
	 * I have just defined all these 5 parameters by checking the memory map of the SLCR(System Level Control Register)
	 * written in the zynq TRM document of Xilinx
	 */
//	INTPTR SLCR_UNLOCK = XPAR_PS7_SLCR_0_S_AXI_BASEADDR + 0x00000008;
//	INTPTR FPGA_RST_CTRL = XPAR_PS7_SLCR_0_S_AXI_BASEADDR + 0x00000240;
//	INTPTR SLCR_LOCK = XPAR_PS7_SLCR_0_S_AXI_BASEADDR + 0x00000004;
//	u32 SLCR_UNLOCK_VAL = 0xDF0D;
//	u32 SLCR_LOCK_VAL = 0x767B;
//
//	Xil_Out32(SLCR_UNLOCK, SLCR_UNLOCK_VAL); //
//	Xil_Out32(FPGA_RST_CTRL, 0xFFFFFFFF);    //Disable AXI Interface
//	Xil_Out32(SLCR_LOCK, SLCR_LOCK_VAL);     //

	// Clear DMA and PCAP Done Interrupts
	XDcfg_IntrClear(Instance, (XDCFG_IXR_DMA_DONE_MASK | XDCFG_IXR_D_P_DONE_MASK));

	// Transfer bitstream from DDR into fabric in non secure mode
	Status = XDcfg_Transfer(Instance, (u32 *) StartAddress, WordLength, (u32 *) XDCFG_DMA_INVALID_ADDRESS, 0, XDCFG_NON_SECURE_PCAP_WRITE);
	if (Status != XST_SUCCESS)
		return Status;

	// Poll DMA Done Interrupt
	while ((IntrStsReg & XDCFG_IXR_DMA_DONE_MASK) != XDCFG_IXR_DMA_DONE_MASK)
		IntrStsReg = XDcfg_IntrGetStatus(Instance);

	// Poll PCAP Done Interrupt
	while ((IntrStsReg & XDCFG_IXR_D_P_DONE_MASK) != XDCFG_IXR_D_P_DONE_MASK)
		IntrStsReg = XDcfg_IntrGetStatus(Instance);

//	Xil_Out32(SLCR_UNLOCK, SLCR_UNLOCK_VAL);   //
//	Xil_Out32(FPGA_RST_CTRL, 0x0);             // Enable AXI Interface
//	Xil_Out32(SLCR_LOCK, SLCR_LOCK_VAL);       //

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

u32 TransferDataFromSD(const char *filename, u32 DestinationAddress)
{

	//FRESULT rc;

	/*
	 * Register volume work area, initialize device
	 * correlate SD card to the pointer &fatfs
	 * */
	result = f_mount(&fatfs, path, 0);
	xil_printf("result = %d\r\n", result);
	if (result != FR_OK) {
		xil_printf(" ERROR : f_mount returned %d\r\n", result);
		return XST_FAILURE;
	}

	strcpy_rom(buffer, filename);
	boot_file = (char *)buffer;

	/*
	 * &fil correlated to the file name in READ mode
	 * */
	result = f_open(&fil, boot_file, FA_READ);
	if (result) {
		xil_printf(" ERROR : f_open returned %d\r\n", result);
		return XST_FAILURE;
	}

	//UINT br;

	result = f_lseek(&fil, 0);
	if (result) {
		xil_printf(" ERROR : f_lseek returned %d\r\n", result);
		return XST_FAILURE;
	}

	/*
	 * the fourth parameter might be wrong if it doesn't work
	 * &fil.fsize ??
	 */
	result = f_read(&fil, (void*)DestinationAddress, BITFILE_LEN, &BytesRd);

	if (result) {
		xil_printf(" ERROR : f_read returned %d\r\n", result);
		return XST_FAILURE;
	}

	xil_printf("SD to DDR Done!!\r\n");

	return XST_SUCCESS;
}

int main()
{

  xil_printf("Hello!!\n\r\n\r");
  Xil_DCacheDisable();

  int i;
  static unsigned int rand_num = 528;	//seed number
  unsigned int count;

  int Status;

  /*
   * initialize the DevConfig down here
   */
  XDcfg_0 = XDcfg_Initialize(XPAR_PS7_DEV_CFG_0_DEVICE_ID);
  if (XDcfg_0 == NULL) return XST_FAILURE;

  /*
   * Partial BIN File transaction down here
   * BIN File from the SD card to DDR
   */
  Status = TransferDataFromSD("np.bin", NOISE_PARTIAL_BITSTREAM_SOURCE_ADDR);
  if (Status != XST_SUCCESS) {
    	return XST_FAILURE;
  }

  xil_printf("Off we go, buddies!!\n\r\n\r");

  //random number generator
//  for (i = 0; i < DATA_NUM; i++) {
//	  rand_num = rand_num ^ (rand_num << 13);
//	  rand_num = rand_num ^ (rand_num >> 17);
//	  rand_num = rand_num ^ (rand_num << 15);
//	  test_data[i] = rand_num;
//  }

  /*
   *
   */
  for (i = 0; i < DATA_NUM; i++) {
    test_data[i] = (i + 31) * (i + 44);
  }

  //pr_port enable
  axi_pr_ctrl[0] = 0x1;

  //kick mm2s
  axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
  axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_SRCADDR_OFFSET) >> 2] = test_data;
  axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

  //kick s2mm
  axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
  axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_DESTADDR_OFFSET) >> 2] = result_data;
  axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

  while (1){
	if ((axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET) >> 2] & 0x2) != 0x0)
	  break;
  }

  for (i = 0; i < DATA_NUM; i++) xil_printf("%d : data = %d, result = %d \n\r", i, test_data[i], result_data[i]);

  // Transfer NOISE Bitstream using DEVCFG/PCAP
  Status = XDcfg_TransferBitfile(XDcfg_0, NOISE_PARTIAL_BITSTREAM_SOURCE_ADDR, (BITFILE_LEN >> 2));
  if (Status != XST_SUCCESS) {
  	xil_printf("ERROR : FPGA configuration failed!\n\r\n\r");
  	exit(EXIT_FAILURE);
  }

  //kick mm2s
  axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
  axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_SRCADDR_OFFSET) >> 2] = test_data;
  axi_dma[(XAXIDMA_TX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

  //kick s2mm
  axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_CR_OFFSET) >> 2] |= 0x1;
  axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_DESTADDR_OFFSET) >> 2] = result_data;
  axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_BUFFLEN_OFFSET) >> 2] = DATA_NUM * sizeof(int);

  while (1){
  	if ((axi_dma[(XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET) >> 2] & 0x2) != 0x0)
  	  break;
  }

  //pr_port disable
  axi_pr_ctrl[0] = 0x0;

  for (i = 0; i < DATA_NUM; i++) xil_printf("%d : data = %d, result = %d \n\r", i, test_data[i], result_data[i]);

  return 0;
}
