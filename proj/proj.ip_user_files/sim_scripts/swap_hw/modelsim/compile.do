vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"./../../../bd/swap_hw/ipshared/user.org/swap_v1_0/hdl/SWAP_v1_0_S_AXIS.v" \
"./../../../bd/swap_hw/ipshared/user.org/swap_v1_0/hdl/SWAP_v1_0_M_AXIS.v" \
"./../../../bd/swap_hw/ipshared/user.org/swap_v1_0/hdl/RAND.v" \
"./../../../bd/swap_hw/ipshared/user.org/swap_v1_0/hdl/SWAP_v1_0.v" \
"./../../../bd/swap_hw/ip/swap_hw_SWAP_0_0/sim/swap_hw_SWAP_0_0.v" \
"./../../../bd/swap_hw/ipshared/xilinx.com/xlconstant_v1_1/xlconstant.v" \
"./../../../bd/swap_hw/ip/swap_hw_xlconstant_0_0/sim/swap_hw_xlconstant_0_0.v" \
"./../../../bd/swap_hw/ip/swap_hw_xlconstant_1_0/sim/swap_hw_xlconstant_1_0.v" \
"./../../../bd/swap_hw/hdl/swap_hw.v" \


vlog -work xil_defaultlib "glbl.v"

