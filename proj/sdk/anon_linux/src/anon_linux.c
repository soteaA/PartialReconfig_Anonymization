/*
 * Copyright (c) 2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
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


#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <time.h>

#define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
#define PR_BIN_SIZE 0x00033148

typedef enum {
	MASKING,
	NOISE_ADDITION,
	MICRO_AGGREGATION,
	SWAPPING
} anon_type;

static struct {
	anon_type type;
	const char *display_text;
	const char *dt_comp_string;
	const char *pr_file_name;
	char pr_buf[PR_BIN_SIZE];
	unsigned int is_static;
	int index;
} anon_types[] = {
		{MASKING, "MASKING", "", "masking.bin", {0}, 0, -1},
		{NOISE_ADDITION, "NOISE ADDITION", "", "noise.bin", {0}, 0, -1},
		{MICRO_AGGREGATION, "MICRO AGGREGATION", "", "micro_aggregation.bin", {0}, 0, -1},
		{SWAPPING, "SWAPPING", "", "swapping.bin", {0}, 0, -1}
};

/*
 * A set of functions for Dynamic Partial Reconfiguration
 */
int partial_prefetch_bin();					//load partial bitstream file from SD into main memory
int partial_reconfig_bin(anon_type type);	//load partial bitstream file from main memory on to FPGA reconfigurable partition
char *anon_type_pr_buf(anon_type type);		//check if the argument 'type' exists

/*
 * A set of functions for AXI DMA transactions
 */

//Coming Soon!!

/*
 * Other basic functions
 */
void delay(double *time);


int main()
{
	double time = 1;
	int i;

	for (i=0; i<10; i++) {
		delay(&time);
		printf("Hello World\n");
	}

    return 0;
}

int partial_prefetch_bin() {
    char file_name[128];
    int fd;
    int ret;
    unsigned int i;

    for (i = 0; i < ARRAY_SIZE(anon_types); ++i) {
        if (anon_types[i].pr_file_name[0] != '\0') {
            // compose file name
            sprintf(file_name, "/media/card/partial/%s", anon_types[i].pr_file_name);

            // open partial bitfile
            fd = open(file_name, O_RDONLY);
            if (fd < 0) {
                printf("failed to open partial bitfile %s\n", file_name);
                return -1;
            }

            // read partial bitfile into buffer
            ret = read(fd, anon_types[i].pr_buf, PR_BIN_SIZE);
            if (ret < 0) {
                printf("failed to read partial bitfile %s\n", file_name);
                close(fd);
                return -1;
            }

            // close file handle
            close(fd);
        }
    }

    return 0;
}

int partial_reconfig_bin(anon_type type) {
    int fd;

    // Set is_partial_bitfile device attribute
    fd = open("/sys/devices/soc0/amba/f8007000.devcfg/is_partial_bitstream", O_RDWR);
    if (fd < 0) {
        printf("failed to set xdevcfg attribute 'is_partial_bitstream'\n");
        return -1;
    }
    write(fd, "1", 2);
    close(fd);

    // Write partial bitfile to xdevcfg device
    fd = open("/dev/xdevcfg", O_RDWR);
    if (fd < 0) {
        printf("failed to open xdevcfg device\n");
        return -1;
    }
    write(fd, anon_type_pr_buf(type), PR_BIN_SIZE);
    close(fd);

    return 0;
}

char *anon_type_pr_buf(anon_type type) {
	unsigned int i;

	for (i =0; i< ARRAY_SIZE(anon_types); ++i) {
		if(anon_types[i].type == type) return anon_types[i].pr_buf;
	}

	return NULL;
}



void delay(double *time) {
	clock_t start, end;
	static double time_diff;

	start = clock();

	do {
		end = clock();
		time_diff = (double) (end-start)/CLOCKS_PER_SEC;
	} while(time_diff < *time);

}

