# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "./.Xil/Vivado-6394-einsamerwolf-HP-Z840-Workstation/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7z020clg484-1

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog -include {
    /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/processing_system7_bfm_v2_0/hdl
    /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ip/anon_hw_processing_system7_0_0
    /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog
  } {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/hdl/top.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/processing_system7_v5_5/hdl/verilog/processing_system7_v5_5_aw_atc.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/processing_system7_v5_5/hdl/verilog/processing_system7_v5_5_b_atc.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/processing_system7_v5_5/hdl/verilog/processing_system7_v5_5_w_atc.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/processing_system7_v5_5/hdl/verilog/processing_system7_v5_5_atc.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/processing_system7_v5_5/hdl/verilog/processing_system7_v5_5_trace_buffer.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ip/anon_hw_processing_system7_0_0/hdl/verilog/processing_system7_v5_5_processing_system7.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ip/anon_hw_processing_system7_0_0/synth/anon_hw_processing_system7_0_0.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_and.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_or.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter_sasd.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_decoder.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_arbiter_resp.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar_sasd.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_decerr_slave.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_si_transactor.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_splitter.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_mux.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_router.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_axi_crossbar.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ip/anon_hw_xbar_0/synth/anon_hw_xbar_0.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/hdl/anon_hw.v
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ip/anon_hw_xbar_1/synth/anon_hw_xbar_1.v
    }
      rt::read_vhdl -lib lib_pkg_v1_0_2 /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/lib_pkg_v1_0/hdl/src/vhdl/lib_pkg.vhd
      rt::read_vhdl -lib lib_fifo_v1_0_3 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/lib_fifo_v1_0/hdl/src/vhdl/async_fifo_fg.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/lib_fifo_v1_0/hdl/src/vhdl/sync_fifo_fg.vhd
    }
      rt::read_vhdl -lib lib_srl_fifo_v1_0_2 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/lib_srl_fifo_v1_0/hdl/src/vhdl/cntr_incr_decr_addn_f.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/lib_srl_fifo_v1_0/hdl/src/vhdl/dynshreg_f.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_rbu_f.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_f.vhd
    }
      rt::read_vhdl -lib lib_cdc_v1_0_2 /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/lib_cdc_v1_0/hdl/src/vhdl/cdc_sync.vhd
      rt::read_vhdl -lib axi_datamover_v5_1_8 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_reset.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_afifo_autord.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_sfifo_autord.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_fifo.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_cmd_status.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_scc.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_strb_gen2.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_pcc.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_addr_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rdmux.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rddata_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rd_status_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wr_demux.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wrdata_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wr_status_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_skid2mm_buf.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_skid_buf.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rd_sf.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wr_sf.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_stbs_set.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_stbs_set_nodre.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_ibttcc.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_indet_btt.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_dre_mux2_1_x_n.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_dre_mux4_1_x_n.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_dre_mux8_1_x_n.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_dre.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_dre.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_ms_strb_set.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mssai_skid_buf.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_slice.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_scatter.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_realign.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_basic_wrap.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_omit_wrap.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_full_wrap.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_basic_wrap.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_omit_wrap.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_full_wrap.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover.vhd
    }
      rt::read_vhdl -lib axi_sg_v4_1_2 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_pkg.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_reset.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_sfifo_autord.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_afifo_autord.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_fifo.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_cmd_status.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_rdmux.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_addr_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_rddata_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_rd_status_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_scc.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_wr_demux.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_scc_wr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_skid2mm_buf.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_wrdata_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_wr_status_cntl.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_skid_buf.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_mm2s_basic_wrap.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_s2mm_basic_wrap.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_datamover.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_sm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_pntr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_cmdsts_if.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_mngr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_cntrl_strm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_queue.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_noqueue.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_q_mngr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_cmdsts_if.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_sm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_mngr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_queue.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_noqueue.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_q_mngr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg_intrpt.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_sg_v4_1/hdl/src/vhdl/axi_sg.vhd
    }
      rt::read_vhdl -lib axi_dma_v7_1_7 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_pkg.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_reset.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_rst_module.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_lite_if.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_register.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_register_s2mm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_reg_module.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_skid_buf.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_afifo_autord.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_sofeof_gen.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_smple_sm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_sg_if.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_sm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_cmdsts_if.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_sts_mngr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_cntrl_strm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_mngr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_sg_if.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_sm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_cmdsts_if.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_sts_mngr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_sts_strm.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_mngr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma_cmd_split.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_dma_v7_1/hdl/src/vhdl/axi_dma.vhd
    }
      rt::read_vhdl -lib blk_mem_gen_v8_3_0 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/blk_mem_gen_v8_3/hdl/blk_mem_gen_v8_3_vhsyn_rfs.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/blk_mem_gen_v8_3/hdl/blk_mem_gen_v8_3.vhd
    }
      rt::read_vhdl -lib fifo_generator_v13_0_0 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/fifo_generator_v13_0/hdl/fifo_generator_v13_0_vhsyn_rfs.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/fifo_generator_v13_0/hdl/fifo_generator_v13_0.vhd
    }
      rt::read_vhdl -lib xil_defaultlib {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ip/anon_hw_axi_dma_0_0/synth/anon_hw_axi_dma_0_0.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ip/anon_hw_rst_processing_system7_0_50M_0/synth/anon_hw_rst_processing_system7_0_50M_0.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ip/anon_hw_axi_gpio_0_0/synth/anon_hw_axi_gpio_0_0.vhd
    }
      rt::read_vhdl -lib proc_sys_reset_v5_0_8 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/proc_sys_reset_v5_0/hdl/src/vhdl/upcnt_n.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/proc_sys_reset_v5_0/hdl/src/vhdl/sequence_psr.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/proc_sys_reset_v5_0/hdl/src/vhdl/lpf.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/proc_sys_reset_v5_0/hdl/src/vhdl/proc_sys_reset.vhd
    }
      rt::read_vhdl -lib axi_lite_ipif_v3_0_3 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_lite_ipif_v3_0/hdl/src/vhdl/ipif_pkg.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_lite_ipif_v3_0/hdl/src/vhdl/pselect_f.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_lite_ipif_v3_0/hdl/src/vhdl/address_decoder.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_lite_ipif_v3_0/hdl/src/vhdl/axi_lite_ipif.vhd
    }
      rt::read_vhdl -lib interrupt_control_v3_1_2 /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/interrupt_control_v3_1/hdl/src/vhdl/interrupt_control.vhd
      rt::read_vhdl -lib axi_gpio_v2_0_8 {
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_gpio_v2_0/hdl/src/vhdl/gpio_core.vhd
      /home/einsamer-wolf/Vivado/proj/anon_pr_1/proj/proj.srcs/sources_1/bd/anon_hw/ipshared/xilinx.com/axi_gpio_v2_0/hdl/src/vhdl/axi_gpio.vhd
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top top
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "./.Xil/Vivado-6394-einsamerwolf-HP-Z840-Workstation/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
      rt::run_rtlelab -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }


    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  if { [info exists rt::helper_shm_key] && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] && [info exists rt::doParallel] && $rt::doParallel} { 
     $rt::db killSynthHelper $rt::helper_shm_key
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
