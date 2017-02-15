vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vlog -work xil_defaultlib -64 +incdir+"../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl" +incdir+"./../../../../proj.srcs/sources_1/bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl" +incdir+"../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl" +incdir+"./../../../../proj.srcs/sources_1/bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl" \
"./../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl/MICRO_AGG_v1_0_S_AXIS.v" \
"./../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl/MICRO_AGG_v1_0_M_AXIS.v" \
"./../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl/four.v" \
"./../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl/eight.v" \
"./../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl/thtwo.v" \
"./../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl/steen.v" \
"./../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl/sum_reg.v" \
"./../../../bd/micro_hw/ipshared/user.org/micro_agg_v1_0/hdl/MICRO_AGG_v1_0.v" \
"./../../../bd/micro_hw/ip/micro_hw_MICRO_AGG_0_0/sim/micro_hw_MICRO_AGG_0_0.v" \
"./../../../bd/micro_hw/hdl/micro_hw.v" \


vlog -work xil_defaultlib "glbl.v"

