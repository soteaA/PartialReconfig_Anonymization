/*
* Copyright (c) 2009 Xilinx, Inc. All rights reserved.
*
* Xilinx, Inc.
* XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
* COURTESY TO YOU. BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
* ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
* STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
* IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
* FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
* XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
* THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
* ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
* FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
* AND FITNESS FOR A PARTICULAR PURPOSE.
*
*/
/*
* helloworld.c: simple test application
*/
#include <stdio.h>
#include "platform.h"
#include "xil_types.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xgpiops.h"
#include "xil_io.h"
static XGpioPs psGpioInstancePtr;
extern XGpioPs_Config XGpioPs_ConfigTable[XPAR_XGPIOPS_NUM_INSTANCES];
static int InterruptFlag;

int main()
{
static XGpio GPIOInstance_Ptr;
XGpioPs_Config*GpioConfigPtr;
XTmrCtr TimerInstancePtr;
int xStatus;
u32 Readstatus=0,OldReadStatus=0;
//u32 EffectiveAdress = 0xE000A000;
int iPinNumberEMIO = 54;
u32 uPinDirectionEMIO = 0x0;
// Input Pin
// Pin direction
u32 uPinDirection = 0x1;
int exit_flag,choice,internal_choice;
init_platform();
/* data = *(u32 *)(0x42800004);
print("OK \n");
data = *(u32 *)(0x41200004);
print("OK-1 \n");
*/
print("##### Application Starts #####\n\r");
print("\r\n");
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Step-1 :AXI GPIO Initialization
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
xStatus = XGpio_Initialize(&GPIOInstance_Ptr,XPAR_AXI_GPIO_0_DEVICE_ID);
if(XST_SUCCESS != xStatus)
print("GPIO INIT FAILED\n\r");
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Step-2 :AXI GPIO Set the Direction
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XGpio_SetDataDirection(&GPIOInstance_Ptr, 1,1);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Step-7 :PS GPIO Intialization
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GpioConfigPtr = XGpioPs_LookupConfig(XPAR_PS7_GPIO_0_DEVICE_ID);
if(GpioConfigPtr == NULL)
return XST_FAILURE;
xStatus = XGpioPs_CfgInitialize(&psGpioInstancePtr,
GpioConfigPtr,
GpioConfigPtr->BaseAddr);
if(XST_SUCCESS != xStatus)
print(" PS GPIO INIT FAILED \n\r");
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Step-8 :PS GPIO pin setting to Output
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XGpioPs_SetDirectionPin(&psGpioInstancePtr, iPinNumber,uPinDirection);
XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, iPinNumber,1);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Step-9 :EMIO PIN Setting to Input port
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
XGpioPs_SetDirectionPin(&psGpioInstancePtr,
iPinNumberEMIO,uPinDirectionEMIO);
XGpioPs_SetOutputEnablePin(&psGpioInstancePtr, iPinNumberEMIO,0);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Step-11 :User selection procedure to select and execute tests
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
exit_flag = 0;
while(exit_flag != 1)
{
print(" SELECT the Operation from the Below Menu \r\n");
print("###################### Menu Starts ########################\r\n");
print("Press '1' to use NORMAL GPIO as an input (SW5 switch)\r\n");
print("Press '2' to use EMIO as an input (SW7 switch)\r\n");
print("Press any other key to Exit\r\n");
print(" ##################### Menu Ends #########################\r\n");
choice = inbyte();
printf("Selection : %c \r\n",choice);
internal_choice = 1;
switch(choice)
{
//~~~~~~~~~~~~~~~~~~~~~~~
// Use case for AXI GPIO
//~~~~~~~~~~~~~~~~~~~~~~~~
case '1':
exit_flag = 0;
print("Press Switch 'SW5' push button on board \r\n");
print(" \r\n");
while(internal_choice != '0')
{
Readstatus = XGpio_DiscreteRead(&GPIOInstance_Ptr, 1);
if(1== Readstatus && 0 == OldReadStatus )
{
print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\r\n");
print("SW5 PUSH Button pressed \n\r");
print("LED 'DS23' Turned OFF \r\n");
XGpioPs_WritePin(&psGpioInstancePtr,iPinNumber,0);
//Start Timer
XTmrCtr_Start(&TimerInstancePtr,0);
print("timer start \n\r");
//Wait For interrupt;
print("Wait for the Timer interrupt to trigger \r\n");
print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\r\n");
print(" \r\n");
while(InterruptFlag != 1);
InterruptFlag = 0;
print(" ###########################################\r\n ");
print("Press '0' to go to Main Menu \n\r ");
print("Press any other key to remain in AXI GPIO Test \n\r ");
print(" ###########################################\r\n ");
internal_choice = inbyte();
printf("Select = %c \r\n",internal_choice);
if(internal_choice != '0')
{
print("Press Switch 'SW5' push button on board \r\n");
}
}
OldReadStatus = Readstatus;
}
print(" \r\n");
print(" \r\n");
break;
case '2' :
	//~~~~~~~~~~~~~~~~~~~~~~~
	//Usecase for PS GPIO
	//~~~~~~~~~~~~~~~~~~~~~~~~
	exit_flag = 0;
	print("Press Switch 'SW7' push button on board \r\n");
	print(" \r\n");
	while(internal_choice != '0')
	{
	Readstatus = XGpioPs_ReadPin(&psGpioInstancePtr,
	iPinNumberEMIO);
	if(1== Readstatus && 0 == OldReadStatus )
	{
	print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\r\n");
	print("SW7 PUSH Button pressed \n\r");
	print("LED 'DS23' Turned OFF \r\n");
	XGpioPs_WritePin(&psGpioInstancePtr,iPinNumber,0);
	//Start Timer
	XTmrCtr_Start(&TimerInstancePtr,0);
	print("timer start \n\r");
	//Wait For interrupt;
	print("Wait for the Timer interrupt to tigger \r\n");
	print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\r\n");
	print(" \r\n");
	while(InterruptFlag != 1);
	InterruptFlag = 0;
	print(" ###########################################\r\n ");
	print("Press '0' to go to Main Menu \n\r ");
	print("Press any other key to remain in EMIO Test \n\r ");
	print(" ###########################################\r\n ");
	internal_choice = inbyte();
	printf("Select = %c \r\n",internal_choice);
	if(internal_choice != '0')
	{
	print("Press Switch 'SW7' push button on board \r\n");
	}
	}
	OldReadStatus = Readstatus;
	}
	print(" \r\n");
	print(" \r\n");
	break;
	default :
	exit_flag = 1;
	break;
	}
	}
	print("\r\n");
	print("***********\r\n");
	print("BYE \r\n");
	print("***********\r\n");
	cleanup_platform();
	return 0;
	}

