set device  "xc7z020"
set package "clg484"
set speed   "-1"
set part    $device$package$speed

set pwd_path [pwd]

#Block Design
set bd_name "anon_hw"
set bd_dir  "proj.srcs/sources_1/bd/anon_hw/"
set bd_path $pwd_path/$bd_dir/$bd_name

#Anonymization IP
set pr_bd_dir "proj.srcs/sources_1/bd/"
set pr_bd_path $pwd_path/$pr_bd_dir/

#directory
set hdl_dir        $pwd_path/hdl
set xdc_dir        $pwd_path/xdc
set checkpoint_dir $pwd_path/checkpoint
set bitfile_dir    $pwd_path/bit_file
set report_dir     $pwd_path/report
set export_dir     $pwd_path/sdk

#export file name
set bd_hwdef "anon_pr"
set bd_hdf   "anon_pr"


#static part file name
## verilog file
set top_module  "top"
## ip core
## you can freely add any IP ##
## ILA can be added here ##
#set static_ip0 $pwd_path/ila_0/ila_0

#identifier of each report files
set synth_part "_synth"
set impl_part  "_impl"
set util       "_util"
set timing     "_timing"


#pr0 (partial reconfiguration part 0)
##static part
set pr0_name "anon_pr"
set pr0_cell "anon_pr_inst"
set pr0_pblock pblock_$pr0_name
set pr0_static static_$pr0_name
#mask (pr module0)
set pr0_0_module "mask_hw"
set pr0_0_file0 "mask_hw_wrapper"
set pr0_0_bd0 $pr_bd_path/mask_hw/mask_hw
#noise (pr module1)
set pr0_1_module "noise_hw"
set pr0_1_file0 "noise_hw_wrapper"
set pr0_1_bd0 $pr_bd_path/noise_hw/noise_hw
#swap (pr module2)
set pr0_2_module "swap_hw"
set pr0_2_file0 "swap_hw_wrapper"
set pr0_2_bd0 $pr_bd_path/swap_hw/swap_hw
#micro_agg (pr module3)
set pr0_3_module "micro_hw"
set pr0_3_file0 "micro_hw_wrapper"
set pr0_3_bd0 $pr_bd_path/micro_hw/micro_hw

set pr0_0_prmodule $bitfile_dir/mask_hw_pblock_anon_pr_partial
set pr0_1_prmodule $bitfile_dir/noise_hw_pblock_anon_pr_partial
set pr0_2_prmodule $bitfile_dir/swap_hw_pblock_anon_pr_partial
set pr0_3_prmodule $bitfile_dir/micro_hw_pblock_anon_pr_partial

