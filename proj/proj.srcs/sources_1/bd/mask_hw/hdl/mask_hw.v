//Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
//Date        : Mon Jun 13 17:54:29 2016
//Host        : einsamerwolf-HP-Z840-Workstation running 64-bit Ubuntu 14.04.4 LTS
//Command     : generate_target mask_hw.bd
//Design      : mask_hw
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "mask_hw,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=mask_hw,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,synth_mode=Global}" *) (* HW_HANDOFF = "mask_hw.hwdef" *) 
module mask_hw
   (M_AXIS_tdata,
    M_AXIS_tlast,
    M_AXIS_tready,
    M_AXIS_tstrb,
    M_AXIS_tvalid,
    S_AXIS_tdata,
    S_AXIS_tlast,
    S_AXIS_tready,
    S_AXIS_tstrb,
    S_AXIS_tvalid,
    m_axis_aclk,
    m_axis_aresetn,
    s_axis_aclk,
    s_axis_aresetn);
  output [31:0]M_AXIS_tdata;
  output M_AXIS_tlast;
  input M_AXIS_tready;
  output [3:0]M_AXIS_tstrb;
  output M_AXIS_tvalid;
  input [31:0]S_AXIS_tdata;
  input S_AXIS_tlast;
  output S_AXIS_tready;
  input [3:0]S_AXIS_tstrb;
  input S_AXIS_tvalid;
  input m_axis_aclk;
  input m_axis_aresetn;
  input s_axis_aclk;
  input s_axis_aresetn;

  wire [31:0]MASK_0_M_AXIS_TDATA;
  wire MASK_0_M_AXIS_TLAST;
  wire MASK_0_M_AXIS_TREADY;
  wire [3:0]MASK_0_M_AXIS_TSTRB;
  wire MASK_0_M_AXIS_TVALID;
  wire [31:0]S_AXIS_1_TDATA;
  wire S_AXIS_1_TLAST;
  wire S_AXIS_1_TREADY;
  wire [3:0]S_AXIS_1_TSTRB;
  wire S_AXIS_1_TVALID;
  wire m_axis_aclk_1;
  wire m_axis_aresetn_1;
  wire s_axis_aclk_1;
  wire s_axis_aresetn_1;
  wire [31:0]xlconstant_0_dout;

  assign MASK_0_M_AXIS_TREADY = M_AXIS_tready;
  assign M_AXIS_tdata[31:0] = MASK_0_M_AXIS_TDATA;
  assign M_AXIS_tlast = MASK_0_M_AXIS_TLAST;
  assign M_AXIS_tstrb[3:0] = MASK_0_M_AXIS_TSTRB;
  assign M_AXIS_tvalid = MASK_0_M_AXIS_TVALID;
  assign S_AXIS_1_TDATA = S_AXIS_tdata[31:0];
  assign S_AXIS_1_TLAST = S_AXIS_tlast;
  assign S_AXIS_1_TSTRB = S_AXIS_tstrb[3:0];
  assign S_AXIS_1_TVALID = S_AXIS_tvalid;
  assign S_AXIS_tready = S_AXIS_1_TREADY;
  assign m_axis_aclk_1 = m_axis_aclk;
  assign m_axis_aresetn_1 = m_axis_aresetn;
  assign s_axis_aclk_1 = s_axis_aclk;
  assign s_axis_aresetn_1 = s_axis_aresetn;
  mask_hw_MASK_0_0 MASK_0
       (.m_axis_aclk(m_axis_aclk_1),
        .m_axis_aresetn(m_axis_aresetn_1),
        .m_axis_tdata(MASK_0_M_AXIS_TDATA),
        .m_axis_tlast(MASK_0_M_AXIS_TLAST),
        .m_axis_tready(MASK_0_M_AXIS_TREADY),
        .m_axis_tstrb(MASK_0_M_AXIS_TSTRB),
        .m_axis_tvalid(MASK_0_M_AXIS_TVALID),
        .mask_level(xlconstant_0_dout[4:0]),
        .s_axis_aclk(s_axis_aclk_1),
        .s_axis_aresetn(s_axis_aresetn_1),
        .s_axis_tdata(S_AXIS_1_TDATA),
        .s_axis_tlast(S_AXIS_1_TLAST),
        .s_axis_tready(S_AXIS_1_TREADY),
        .s_axis_tstrb(S_AXIS_1_TSTRB),
        .s_axis_tvalid(S_AXIS_1_TVALID));
  mask_hw_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule