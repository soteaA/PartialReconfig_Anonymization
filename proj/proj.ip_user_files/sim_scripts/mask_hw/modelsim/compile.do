vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"./../../../bd/mask_hw/ipshared/user.org/mask_v1_0/hdl/MASK_v1_0_S_AXIS.v" \
"./../../../bd/mask_hw/ipshared/user.org/mask_v1_0/hdl/MASK_v1_0_M_AXIS.v" \
"./../../../bd/mask_hw/ipshared/user.org/mask_v1_0/hdl/MASK_v1_0.v" \
"./../../../bd/mask_hw/ip/mask_hw_MASK_0_0/sim/mask_hw_MASK_0_0.v" \
"./../../../bd/mask_hw/ipshared/xilinx.com/xlconstant_v1_1/xlconstant.v" \
"./../../../bd/mask_hw/ip/mask_hw_xlconstant_0_0/sim/mask_hw_xlconstant_0_0.v" \
"./../../../bd/mask_hw/hdl/mask_hw.v" \


vlog -work xil_defaultlib "glbl.v"

