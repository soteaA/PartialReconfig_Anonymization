vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"./../../../bd/noise_hw/hdl/noise_hw.v" \
"./../../../bd/noise_hw/ipshared/user.org/noise_v1_0/hdl/NOISE_v1_0_S_AXIS.v" \
"./../../../bd/noise_hw/ipshared/user.org/noise_v1_0/hdl/NOISE_v1_0_M_AXIS.v" \
"./../../../bd/noise_hw/ipshared/user.org/noise_v1_0/hdl/NOISE_v1_0.v" \
"./../../../bd/noise_hw/ip/noise_hw_NOISE_0_0/sim/noise_hw_NOISE_0_0.v" \
"./../../../bd/noise_hw/ipshared/xilinx.com/xlconstant_v1_1/xlconstant.v" \
"./../../../bd/noise_hw/ip/noise_hw_xlconstant_0_0/sim/noise_hw_xlconstant_0_0.v" \
"./../../../bd/noise_hw/ip/noise_hw_xlconstant_1_0/sim/noise_hw_xlconstant_1_0.v" \


vlog -work xil_defaultlib "glbl.v"

