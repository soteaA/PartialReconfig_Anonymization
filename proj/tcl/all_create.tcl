#read parameters
set Tcl_dir "tcl"
source [pwd]/$Tcl_dir/parameters.tcl

#select process
set synth       0
set draw_pblock 1
set impl        0
set bit         0
set bin		0


#synthesis
if {$synth == 1} {
    #top module synthesis
    read_verilog $hdl_dir/$top_module.v
    #read_ip $static_ip0.xci
    read_bd $bd_path.bd
    synth_design -top $top_module -part $part
    write_checkpoint -force $checkpoint_dir/$top_module$synth_part.dcp
    report_utilization -file $report_dir/$top_module$synth_part.rpt
    remove_file $top_module.v

    #mask core synthesis
    read_verilog $hdl_dir/$pr0_0_file0.v
    #read_ip $pr0_0_ip0.xci
	read_bd $pr0_0_bd0.bd
	synth_design -top $pr0_name -part $part -mode out_of_context
    write_checkpoint -force $checkpoint_dir/$pr0_0_module$synth_part.dcp
    report_utilization -file $report_dir/$pr0_0_module$synth_part.rpt
    remove_file $pr0_0_file0.v

    #noise core synthesis
    read_verilog $hdl_dir/$pr0_1_file0.v
    #read_ip $pr0_1_ip0.xci
	read_bd $pr0_1_bd0.bd
	synth_design -top $pr0_name -part $part -mode out_of_context
    write_checkpoint -force $checkpoint_dir/$pr0_1_module$synth_part.dcp
    report_utilization -file $report_dir/$pr0_1_module$synth_part.rpt
    remove_file $pr0_1_file0.v

    #swap core synthesis
    read_verilog $hdl_dir/$pr0_2_file0.v
    #read_ip $pr0_2_ip0.xci
	read_bd $pr0_2_bd0.bd
	synth_design -top $pr0_name -part $part -mode out_of_context
    write_checkpoint -force $checkpoint_dir/$pr0_2_module$synth_part.dcp
    report_utilization -file $report_dir/$pr0_2_module$synth_part.rpt
    remove_file $pr0_2_file0.v

    #micro_agg core synthesis
    read_verilog $hdl_dir/$pr0_3_file0.v
    #read_ip $pr0_3_ip0.xci
    read_bd $pr0_3_bd0.bd
    synth_design -top $pr0_name -part $part -mode out_of_context
    write_checkpoint -force $checkpoint_dir/$pr0_3_module$synth_part.dcp
    report_utilization -file $report_dir/$pr0_3_module$synth_part.rpt
    remove_file $pr0_3_file0.v
}


#draw pblock with GUI
if {$draw_pblock == 1} {
    open_checkpoint $checkpoint_dir/$top_module$synth_part.dcp
    read_checkpoint -cell $pr0_cell $checkpoint_dir/$pr0_3_module$synth_part.dcp
    set_property HD.RECONFIGURABLE true [get_cells $pr0_cell]
    start_gui
}


#implementation
if {$impl == 1} {
    #top + mask implementation
    open_checkpoint $checkpoint_dir/$top_module$synth_part.dcp
    read_xdc $xdc_dir/constr.xdc
    read_checkpoint -cell $pr0_cell $checkpoint_dir/$pr0_0_module$synth_part.dcp
    set_property HD.RECONFIGURABLE true [get_cells $pr0_cell]

    create_pblock $pr0_pblock
    resize_pblock $pr0_pblock -add  {SLICE_X54Y0:SLICE_X73Y49}
    add_cells_to_pblock $pr0_pblock [get_cells [list $pr0_cell]] -clear_locs

    set_property RESET_AFTER_RECONFIG 1 [get_pblocks $pr0_pblock]
    set_property SNAPPING_MODE ON [get_pblocks $pr0_pblock]

    opt_design
    place_design
    route_design
    write_debug_probes debug.ltx -force
    write_checkpoint -force $checkpoint_dir/$pr0_0_module$impl_part.dcp
    report_utilization -file $report_dir/$pr0_0_module$impl_part$util.rpt
    report_timing_summary -file $report_dir/$pr0_0_module$impl_part$timing.rpt
    update_design -cell $pr0_cell -black_box
    write_checkpoint -force $checkpoint_dir/$pr0_static.dcp

    #top + noise implementation
    open_checkpoint $checkpoint_dir/$pr0_static.dcp
    lock_design -level routing
    read_checkpoint -cell $pr0_cell $checkpoint_dir/$pr0_1_module$synth_part.dcp
    opt_design
    place_design
    route_design
    write_checkpoint -force $checkpoint_dir/$pr0_1_module$impl_part.dcp
    report_utilization -file $report_dir/$pr0_1_module$impl_part$util.rpt
    report_timing_summary -file $report_dir/$pr0_1_module$impl_part$timing.rpt

    #top + swap implementation
    open_checkpoint $checkpoint_dir/$pr0_static.dcp
    lock_design -level routing
    read_checkpoint -cell $pr0_cell $checkpoint_dir/$pr0_2_module$synth_part.dcp
    opt_design
    place_design
    route_design
    write_checkpoint -force $checkpoint_dir/$pr0_2_module$impl_part.dcp
    report_utilization -file $report_dir/$pr0_2_module$impl_part$util.rpt    
    report_timing_summary -file $report_dir/$pr0_2_module$impl_part$timing.rpt
	
	#top + micro_agg implementation
    open_checkpoint $checkpoint_dir/$pr0_static.dcp
    lock_design -level routing
    read_checkpoint -cell $pr0_cell $checkpoint_dir/$pr0_3_module$synth_part.dcp
    opt_design
    place_design
    route_design
    write_checkpoint -force $checkpoint_dir/$pr0_3_module$impl_part.dcp
    report_utilization -file $report_dir/$pr0_3_module$impl_part$util.rpt    
    report_timing_summary -file $report_dir/$pr0_3_module$impl_part$timing.rpt
}


#generate bitstream + export hardware
if {$bit == 1} {
    #write bitstream mask
    open_checkpoint $checkpoint_dir/$pr0_0_module$impl_part.dcp
    write_bitstream -bin_file -raw_bitfile -force $bitfile_dir/$pr0_0_module

    #write bitstream noise
    open_checkpoint $checkpoint_dir/$pr0_1_module$impl_part.dcp
    write_bitstream -bin_file -raw_bitfile -force $bitfile_dir/$pr0_1_module

    #write bitstream swap
    open_checkpoint $checkpoint_dir/$pr0_2_module$impl_part.dcp
    write_bitstream -bin_file -raw_bitfile -force $bitfile_dir/$pr0_2_module

	#write bitstream micro_agg
    open_checkpoint $checkpoint_dir/$pr0_3_module$impl_part.dcp
    write_bitstream -bin_file -raw_bitfile -force $bitfile_dir/$pr0_3_module

    #export hardware
    read_bd $bd_path.bd
    write_hwdef -file $export_dir/$bd_hwdef.hwdef -force
    write_sysdef -hwdef $export_dir/$bd_hwdef.hwdef -bitfile $bitfile_dir/$pr0_0_module.bit -file $export_dir/$bd_hdf.hdf -force
}

#generate BIN file for all the partial bitstream 
if {$bin == 1} {
	#write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 $pr0_0_prmodule.bit 
	#up 0x4EE53 $pr0_1_prmodule.bit
	#up 0x9DCA6 $pr0_2_prmodule.bit
	#up 0xECAF9 $pr0_3_prmodule.bit" -file all_partial.bin -force
	write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0x0 $pr0_0_prmodule.bit" -file $pr0_0_prmodule.bin -force
	write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0x0 $pr0_1_prmodule.bit" -file $pr0_1_prmodule.bin -force
	write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0x0 $pr0_2_prmodule.bit" -file $pr0_2_prmodule.bin -force
	write_cfgmem -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0x0 $pr0_3_prmodule.bit" -file $pr0_3_prmodule.bin -force
}



