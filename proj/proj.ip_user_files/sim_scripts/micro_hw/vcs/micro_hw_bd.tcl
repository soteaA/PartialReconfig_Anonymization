
################################################################
# This is a generated script based on design: micro_hw
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source micro_hw_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-1
#    set_property BOARD_PART xilinx.com:zc702:part0:1.2 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name micro_hw

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set M_AXIS [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS ]
  set S_AXIS [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {100000000} \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {1} \
CONFIG.HAS_TREADY {1} \
CONFIG.HAS_TSTRB {1} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.PHASE {0.000} \
CONFIG.TDATA_NUM_BYTES {4} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {0} \
 ] $S_AXIS

  # Create ports
  set m_axis_aclk [ create_bd_port -dir I -type clk m_axis_aclk ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {M_AXIS} \
CONFIG.FREQ_HZ {100000000} \
 ] $m_axis_aclk
  set m_axis_aresetn [ create_bd_port -dir I -type rst m_axis_aresetn ]
  set s_axis_aclk [ create_bd_port -dir I -type clk s_axis_aclk ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {S_AXIS} \
CONFIG.FREQ_HZ {100000000} \
 ] $s_axis_aclk
  set s_axis_aresetn [ create_bd_port -dir I -type rst s_axis_aresetn ]

  # Create instance: MICRO_AGG_0, and set properties
  set MICRO_AGG_0 [ create_bd_cell -type ip -vlnv user.org:user:MICRO_AGG:1.0 MICRO_AGG_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net MICRO_AGG_0_M_AXIS [get_bd_intf_ports M_AXIS] [get_bd_intf_pins MICRO_AGG_0/M_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_ports S_AXIS] [get_bd_intf_pins MICRO_AGG_0/S_AXIS]

  # Create port connections
  connect_bd_net -net m_axis_aclk_1 [get_bd_ports m_axis_aclk] [get_bd_pins MICRO_AGG_0/m_axis_aclk]
  connect_bd_net -net m_axis_aresetn_1 [get_bd_ports m_axis_aresetn] [get_bd_pins MICRO_AGG_0/m_axis_aresetn]
  connect_bd_net -net s_axis_aclk_1 [get_bd_ports s_axis_aclk] [get_bd_pins MICRO_AGG_0/s_axis_aclk]
  connect_bd_net -net s_axis_aresetn_1 [get_bd_ports s_axis_aresetn] [get_bd_pins MICRO_AGG_0/s_axis_aresetn]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port s_axis_aresetn -pg 1 -y -170 -defaultsOSRD
preplace port s_axis_aclk -pg 1 -y -190 -defaultsOSRD
preplace port S_AXIS -pg 1 -y -210 -defaultsOSRD
preplace port m_axis_aresetn -pg 1 -y -130 -defaultsOSRD
preplace port m_axis_aclk -pg 1 -y -150 -defaultsOSRD
preplace port M_AXIS -pg 1 -y -170 -defaultsOSRD
preplace inst MICRO_AGG_0 -pg 1 -lvl 1 -y -170 -defaultsOSRD
preplace netloc s_axis_aclk_1 1 0 1 N
preplace netloc m_axis_aresetn_1 1 0 1 N
preplace netloc m_axis_aclk_1 1 0 1 N
preplace netloc S_AXIS_1 1 0 1 N
preplace netloc MICRO_AGG_0_M_AXIS 1 1 1 N
preplace netloc s_axis_aresetn_1 1 0 1 N
levelinfo -pg 1 -20 120 250 -top -250 -bot 170
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


