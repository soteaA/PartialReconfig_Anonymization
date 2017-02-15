#!/bin/bash -f
# Vivado (TM) v2015.3 (64-bit)
#
# Filename    : micro_hw.sh
# Simulator   : Mentor Graphics ModelSim Simulator
# Description : Simulation script for compiling, elaborating and verifying the project source files.
#               The script will automatically create the design libraries sub-directories in the run
#               directory, add the library logical mappings in the simulator setup file, create default
#               'do' file, copy glbl.v into the run directory for verilog sources in the design (if any),
#               execute compilation, elaboration and simulation steps.
#
# Generated by Vivado on Mon Jun 13 17:54:22 JST 2016
# IP Build 1367837 on Mon Sep 28 08:56:14 MDT 2015 
#
# usage: micro_hw.sh [-help]
# usage: micro_hw.sh [-lib_map_path]
# usage: micro_hw.sh [-noclean_files]
# usage: micro_hw.sh [-reset_run]
#
# Prerequisite:- To compile and run simulation, you must compile the Xilinx simulation libraries using the
# 'compile_simlib' TCL command. For more information about this command, run 'compile_simlib -help' in the
# Vivado Tcl Shell. Once the libraries have been compiled successfully, specify the -lib_map_path switch
# that points to these libraries and rerun export_simulation. For more information about this switch please
# type 'export_simulation -help' in the Tcl shell.
#
# You can also point to the simulation libraries by either replacing the <SPECIFY_COMPILED_LIB_PATH> in this
# script with the compiled library directory path or specify this path with the '-lib_map_path' switch when
# executing this script. Please type 'micro_hw.sh -help' for more information.
#
# Additional references - 'Xilinx Vivado Design Suite User Guide:Logic simulation (UG900)'
#
# ********************************************************************************************************

# Script info
echo -e "micro_hw.sh - Script generated by export_simulation (Vivado v2015.3 (64-bit)-id)\n"

# Script usage
usage()
{
  msg="Usage: micro_hw.sh [-help]\n\
Usage: micro_hw.sh [-lib_map_path]\n\
Usage: micro_hw.sh [-reset_run]\n\
Usage: micro_hw.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}

if [[ ($# == 1 ) && ($1 != "-lib_map_path" && $1 != "-noclean_files" && $1 != "-reset_run" && $1 != "-help" && $1 != "-h") ]]; then
  echo -e "ERROR: Unknown option specified '$1' (type \"./micro_hw.sh -help\" for more information)\n"
  exit 1
fi

if [[ ($1 == "-help" || $1 == "-h") ]]; then
  usage
fi

# STEP: setup
setup()
{
  case $1 in
    "-lib_map_path" )
      if [[ ($2 == "") ]]; then
        echo -e "ERROR: Simulation library directory path not specified (type \"./micro_hw.sh -help\" for more information)\n"
        exit 1
      fi
      # precompiled simulation library directory path
     copy_setup_file $2
     copy_glbl_file
    ;;
    "-reset_run" )
      reset_run
      echo -e "INFO: Simulation run files deleted.\n"
      exit 0
    ;;
    "-noclean_files" )
      # do not remove previous data
    ;;
    * )
     copy_setup_file $2
     copy_glbl_file
  esac

  # Add any setup/initialization commands here:-

  # <user specific commands>

}

# Copy glbl.v file into run directory
copy_glbl_file()
{
  glbl_file="glbl.v"
  src_file="/opt/Xilinx/Vivado/2015.3/data/verilog/src/glbl.v"
  if [[ ! -e $glbl_file ]]; then
    cp $src_file .
  fi
}

# Remove generated data from the previous run and re-create setup files/library mappings
reset_run()
{
  files_to_remove=(compile.log simulate.log vsim.wlf work msim)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done
}

# Main steps
run()
{
  setup $1 $2
  compile
  simulate
}

# Copy modelsim.ini file
copy_setup_file()
{
  file="modelsim.ini"
  lib_map_path="<SPECIFY_COMPILED_LIB_PATH>"
  if [[ ($1 != "" && -e $1) ]]; then
    lib_map_path="$1"
  else
    echo -e "ERROR: Compiled simulation library directory path not specified or does not exist (type "./top.sh -help" for more information)\n"
  fi
  src_file="$lib_map_path/$file"
  cp $src_file .
}


# RUN_STEP: <compile>
compile()
{

  # Compile design files
  source compile.do 2>&1 | tee -a compile.log

}

# RUN_STEP: <simulate>
simulate()
{
  vsim -64 -c -do "do {simulate.do}" -l simulate.log
}
# Script usage
usage()
{
  msg="Usage: micro_hw.sh [-help]\n\
Usage: micro_hw.sh [-lib_map_path]\n\
Usage: micro_hw.sh [-reset_run]\n\
Usage: micro_hw.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}


# Launch script
run $1 $2
