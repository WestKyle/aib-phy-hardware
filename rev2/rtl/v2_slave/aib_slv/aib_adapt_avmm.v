// SPDX-License-Identifier: Apache-2.0
// Copyright (C) 2019 Intel Corporation. 
//-----------------------------------------------------------------------------
//
//-----------------------------------------------------------------------------
// Description: Channel Configuration
//
//
//---------------------------------------------------------------------------
module aib_adapt_avmm(
  input  wire [`TCM_WRAP_CTRL_RNG]  avmm1_tst_tcm_ctrl,
  input  wire                       avmm1_test_clk,
  input  wire                       avmm1_scan_clk,
  input  wire                       scan_rst_n,
  input  wire                       scan_mode_n,
  input  wire [1:0]                 aib_hssi_avmm1_data_in,
  input  wire                       sr_clock_tx_osc_clk_or_clkdiv,
  input  wire                       aib_hssi_rx_sr_clk_in,                 // clock aib_hssi_rx_sr_clk_in straight from AIBIO
  input  wire                       sr_clock_aib_rx_sr_clk,                // clock aib_hssi_rx_sr_clk_in after shared TCM
  input  wire                       avmm1_async_hssi_fabric_ssr_load,
  input  wire                       csr_rdy_dly_in,
  input  wire [31:0]                adpt_cfg_rdata,
  input  wire                       adpt_cfg_rdatavld,
  input  wire                       adpt_cfg_waitreq,
  input  wire                       pld_chnl_cal_done,
  input  wire [7:0]                 rx_chnl_dprio_status,
  input  wire                       rx_chnl_dprio_status_write_en_ack,
  input  wire [7:0]                 sr_dprio_status,
  input  wire                       sr_dprio_status_write_en_ack,
  input  wire [7:0]                 tx_chnl_dprio_status,
  input  wire                       tx_chnl_dprio_status_write_en_ack,
  input  wire                       usermode_in,
  input  wire                       avmm_async_fabric_hssi_ssr_load,
  input  wire                       avmm_hrdrst_fabric_osc_transfer_en_ssr_data,
  input  wire                       avmm_async_hssi_fabric_ssr_load,
  input  wire [7:0]                 sr_testbus,

  output wire                       aib_bsr_scan_shift_clk,

  // CRSSM AVMM
  input  wire   [5:0]               cfg_avmm_addr_id,
  input  wire                       cfg_avmm_clk,
  input  wire                       cfg_avmm_rst_n,
  input  wire                       cfg_avmm_write,
  input  wire                       cfg_avmm_read,
  input  wire  [16:0]               cfg_avmm_addr,
  input  wire  [31:0]               cfg_avmm_wdata,
  input  wire  [3:0]                cfg_avmm_byte_en,
  output wire  [31:0]               cfg_avmm_rdata,
  output wire                       cfg_avmm_rdatavld,
  output wire                       cfg_avmm_waitreq,
  output wire                       o_hard_rst_n,
  output wire                       adpt_cfg_write,
  output wire                       adpt_cfg_read,

  // USR/CFG AVMM1
// User AVMM2
  output wire [7:0]                 r_aib_csr_ctrl_0,
  output wire [7:0]                 r_aib_csr_ctrl_1,
  output wire [7:0]                 r_aib_csr_ctrl_10,
  output wire [7:0]                 r_aib_csr_ctrl_11,
  output wire [7:0]                 r_aib_csr_ctrl_12,
  output wire [7:0]                 r_aib_csr_ctrl_13,
  output wire [7:0]                 r_aib_csr_ctrl_14,
  output wire [7:0]                 r_aib_csr_ctrl_15,
  output wire [7:0]                 r_aib_csr_ctrl_16,
  output wire [7:0]                 r_aib_csr_ctrl_17,
  output wire [7:0]                 r_aib_csr_ctrl_18,
  output wire [7:0]                 r_aib_csr_ctrl_19,
  output wire [7:0]                 r_aib_csr_ctrl_2,
  output wire [7:0]                 r_aib_csr_ctrl_20,
  output wire [7:0]                 r_aib_csr_ctrl_21,
  output wire [7:0]                 r_aib_csr_ctrl_22,
  output wire [7:0]                 r_aib_csr_ctrl_23,
  output wire [7:0]                 r_aib_csr_ctrl_24,
  output wire [7:0]                 r_aib_csr_ctrl_25,
  output wire [7:0]                 r_aib_csr_ctrl_26,
  output wire [7:0]                 r_aib_csr_ctrl_27,
  output wire [7:0]                 r_aib_csr_ctrl_28,
  output wire [7:0]                 r_aib_csr_ctrl_29,
  output wire [7:0]                 r_aib_csr_ctrl_3,
  output wire [7:0]                 r_aib_csr_ctrl_30,
  output wire [7:0]                 r_aib_csr_ctrl_31,
  output wire [7:0]                 r_aib_csr_ctrl_32,
  output wire [7:0]                 r_aib_csr_ctrl_33,
  output wire [7:0]                 r_aib_csr_ctrl_34,
  output wire [7:0]                 r_aib_csr_ctrl_35,
  output wire [7:0]                 r_aib_csr_ctrl_36,
  output wire [7:0]                 r_aib_csr_ctrl_37,
  output wire [7:0]                 r_aib_csr_ctrl_38,
  output wire [7:0]                 r_aib_csr_ctrl_39,
  output wire [7:0]                 r_aib_csr_ctrl_4,
  output wire [7:0]                 r_aib_csr_ctrl_40,
  output wire [7:0]                 r_aib_csr_ctrl_41,
  output wire [7:0]                 r_aib_csr_ctrl_42,
  output wire [7:0]                 r_aib_csr_ctrl_43,
  output wire [7:0]                 r_aib_csr_ctrl_44,
  output wire [7:0]                 r_aib_csr_ctrl_45,
  output wire [7:0]                 r_aib_csr_ctrl_46,
  output wire [7:0]                 r_aib_csr_ctrl_47,
  output wire [7:0]                 r_aib_csr_ctrl_48,
  output wire [7:0]                 r_aib_csr_ctrl_49,
  output wire [7:0]                 r_aib_csr_ctrl_5,
  output wire [7:0]                 r_aib_csr_ctrl_50,
  output wire [7:0]                 r_aib_csr_ctrl_51,
  output wire [7:0]                 r_aib_csr_ctrl_52,
  output wire [7:0]                 r_aib_csr_ctrl_53,
  output wire [7:0]                 r_aib_csr_ctrl_6,
  output wire [7:0]                 r_aib_csr_ctrl_7,
  output wire [7:0]                 r_aib_csr_ctrl_8,
  output wire [7:0]                 r_aib_csr_ctrl_9,
  output wire [7:0]                 r_aib_dprio_ctrl_0,
  output wire [7:0]                 r_aib_dprio_ctrl_1,
  output wire [7:0]                 r_aib_dprio_ctrl_2,
  output wire [7:0]                 r_aib_dprio_ctrl_3,
  output wire [7:0]                 r_aib_dprio_ctrl_4,
  output wire                       r_rx_double_write,
  output wire [1:0]                 r_rx_fifo_mode,
  output wire                       r_rx_lpbk,
  output wire [2:0]                 r_rx_phcomp_rd_delay,
  output wire                       r_rx_wm_en,
  output wire                       r_rx_wr_adj_en,
  output wire                       r_rx_rd_adj_en,
  output wire  [1:0]                r_tx_adapter_lpbk_mode, //tx loopback mode:00 no lpbk. 01 lpbk 2, 10 lpbk 3 reg, 11 lpbk 3 fifo
  output wire                       r_rx_aib_lpbk_en,

  output wire                       r_tx_double_read,
  output wire [1:0]                 r_tx_fifo_mode,
  output wire [1:0]                 r_tx_fifo_rd_clk_sel,
  output wire [2:0]                 r_tx_phcomp_rd_delay,
  output wire                       r_tx_wa_en,
  output wire                       r_tx_wr_adj_en,
  output wire                       r_tx_rd_adj_en
);

wire [3:0]                 avmm_hrdrst_tb_direct;
wire [19:0]                avmm_testbus;
wire                       avmm_transfer_error;
wire                       sr_fabric_osc_transfer_en;
wire             r_avmm2_avmm_clk_dcg_en;
wire             r_avmm2_avmm_clk_scg_en;
wire             r_avmm2_free_run_div_clk;
wire             r_avmm2_hip_sel;
wire             r_avmm2_osc_clk_scg_en;
wire [5:0]       r_avmm2_rdfifo_empty;
wire [5:0]       r_avmm2_rdfifo_full;
wire             r_avmm2_rdfifo_stop_read;
wire             r_avmm2_rdfifo_stop_write;
wire             r_avmm_hrdrst_osc_clk_scg_en;
wire             avmm_clock_csr_clk;
wire             avmm_clock_csr_clk_n;
wire             avmm_clock_hrdrst_rx_osc_clk;
wire             avmm_clock_hrdrst_tx_osc_clk;
wire             avmm_clock_reset_hrdrst_rx_osc_clk;
wire             avmm_clock_reset_hrdrst_tx_osc_clk;
wire             avmm_hrdrst_hssi_osc_transfer_en;
wire             avmm_reset_hrdrst_tx_osc_clk_rst_n;
wire             avmm_reset_hrdrst_rx_osc_clk_rst_n;


wire  [1:0]      r_avmm_testbus_sel;
wire  [14:0]     avmm1_transfer_testbus;
wire  [14:0]     avmm2_transfer_testbus;
wire  [7:0]      avmm1_clock_dcg_testbus;
wire  [7:0]      avmm2_clock_dcg_testbus;
wire  [4:0]      avmm_hrdrst_testbus;
wire  [4:0]      avmm1_cmn_intf_testbus;

wire             avmm1_transfer_error;
wire             avmm2_transfer_error;

wire  [31:0]     cfg_only_rdata;
wire             cfg_only_rdatavld;
wire             cfg_only_waitreq;
wire [31:0]      chnl_cfg_rdata;
wire             chnl_cfg_rdatavld;
wire             chnl_cfg_waitreq;
wire             r_ifctl_usr_active;

wire  [31:0]     cfg_avmm2_rdata;
wire             cfg_avmm2_rdatavld;
wire             cfg_avmm2_waitreq;

wire             cfg_avmm_slave_write;
wire             cfg_avmm_slave_read;
wire             avmm_reset_cfg_avmm_rst_n;
wire             w_cfg_amm_clk;
wire             avmm_clock_reset_avmm2_clk;
wire             cfg_avmm_raw_rst_n;

assign avmm2_clock_dcg_testbus[7:0]= 8'b0;
assign avmm2_transfer_error = 1'b0;
assign avmm2_transfer_testbus[14:0] = 15'b0;
// Send 125 MHz clock for use as bsr[0..3]_scan_shift of AIBIO
assign aib_bsr_scan_shift_clk = avmm_clock_reset_avmm2_clk;

assign avmm_testbus = (r_avmm_testbus_sel == 2'b00) ? {avmm_hrdrst_testbus, avmm1_transfer_testbus} :
                      (r_avmm_testbus_sel == 2'b01) ? {5'h00, avmm2_transfer_testbus} :
                      (r_avmm_testbus_sel == 2'b10) ? {4'h0,  avmm2_clock_dcg_testbus, avmm1_clock_dcg_testbus} :
                                                      {5'b00000, sr_testbus[7:6], sr_testbus[4], sr_testbus[3:2], sr_testbus[0], 4'b0000 ,avmm1_cmn_intf_testbus};

assign avmm_hrdrst_tb_direct[3] = r_ifctl_usr_active;

assign avmm_transfer_error = avmm1_transfer_error | avmm2_transfer_error;

assign adpt_cfg_write = cfg_avmm_slave_write;
assign adpt_cfg_read  = cfg_avmm_slave_read;

c3aibadapt_cfg_rdmux cfg_rdmux (
  // Output
  .cfg_avmm_rdata           (cfg_avmm_rdata),
  .cfg_avmm_rdatavld        (cfg_avmm_rdatavld),
  .cfg_avmm_waitreq         (cfg_avmm_waitreq),
  .cfg_avmm_slave_write     (cfg_avmm_slave_write),
  .cfg_avmm_slave_read      (cfg_avmm_slave_read),

  // Input
  .cfg_write                (cfg_avmm_write),
  .cfg_read                 (cfg_avmm_read),
  .cfg_rst_n                (avmm_reset_cfg_avmm_rst_n),
  .r_ifctl_usr_active       (r_ifctl_usr_active),
  .chnl_cfg_rdata           (chnl_cfg_rdata),
  .chnl_cfg_rdatavld        (chnl_cfg_rdatavld),
  .chnl_cfg_waitreq         (chnl_cfg_waitreq),
  .cfg_only_rdata           (cfg_only_rdata),
  .cfg_only_rdatavld        (cfg_only_rdatavld),
  .cfg_only_waitreq         (cfg_only_waitreq),
  .ehip_cfg_rdata           (32'b0),
  .ehip_cfg_rdatavld        (1'b0),
  .ehip_cfg_waitreq         (1'b1),
  .adpt_cfg_rdata           (adpt_cfg_rdata),
  .adpt_cfg_rdatavld        (adpt_cfg_rdatavld),
  .adpt_cfg_waitreq         (adpt_cfg_waitreq)
);

c3aibadapt_avmm1 avmm1(/*AUTOINST*/
     // Outputs
     // AVMM signals from CRSSM
     .chnl_avmm_rdata                                   (chnl_cfg_rdata),
     .chnl_avmm_rdatavld                                (chnl_cfg_rdatavld),
     .chnl_avmm_waitreq                                 (chnl_cfg_waitreq),
     .cfg_only_rdata                                    (cfg_only_rdata),
     .cfg_only_rdatavld                                 (cfg_only_rdatavld),
     .cfg_only_waitreq                                  (cfg_only_waitreq),
     .aib_hssi_avmm1_data_out                           (),
     .avmm1_hssi_fabric_ssr_data                        (),
     .avmm_transfer_error                               (avmm1_transfer_error),
     .avmm_transfer_testbus                             (avmm1_transfer_testbus),
     .avmm1_clock_dcg_testbus                           (avmm1_clock_dcg_testbus),
     .avmm1_cmn_intf_testbus                            (avmm1_cmn_intf_testbus),
     .dec_arb_tb_direct                                 (),
     .avmm1_clock_avmm_clk_scg                          (),
     .avmm1_clock_avmm_clk_dcg                          (),
     .avmm_clock_reset_avmm2_clk                        (avmm_clock_reset_avmm2_clk),
     .o_xcvrif_avmm_clk                                 (),
     .o_xcvrif_avmm_rst_n                               (),
     .o_xcvrif_avmm_cfg_active                          (),
     .o_xcvrif_avmm_write                               (),
     .o_xcvrif_avmm_read                                (),
     .o_xcvrif_avmm_addr                                (),
     .o_xcvrif_avmm_wdata                               (),
     .o_xcvrif_avmm_byte_en                             (),
     .i_xcvrif_avmm_rdata                               (32'b0),
     .i_xcvrif_avmm_rdatavld                            (1'b0),
     .i_xcvrif_avmm_waitreq                             (1'b0),
     .o_elane_avmm_clk                                  (),
     .o_elane_avmm_rst_n                                (),
     .o_elane_avmm_cfg_active                           (),
     .o_elane_avmm_write                                (),
     .o_elane_avmm_read                                 (),
     .o_elane_avmm_addr                                 (),
     .o_elane_avmm_wdata                                (),
     .o_elane_avmm_byte_en                              (),
     .i_elane_avmm_rdata                                (32'b0),
     .i_elane_avmm_rdatavld                             (1'b0),
     .i_elane_avmm_waitreq                              (1'b0),
     .r_aib_csr_ctrl_0                                  (r_aib_csr_ctrl_0[7:0]),
     .r_aib_csr_ctrl_1                                  (r_aib_csr_ctrl_1[7:0]),
     .r_aib_csr_ctrl_10                                 (r_aib_csr_ctrl_10[7:0]),
     .r_aib_csr_ctrl_11                                 (r_aib_csr_ctrl_11[7:0]),
     .r_aib_csr_ctrl_12                                 (r_aib_csr_ctrl_12[7:0]),
     .r_aib_csr_ctrl_13                                 (r_aib_csr_ctrl_13[7:0]),
     .r_aib_csr_ctrl_14                                 (r_aib_csr_ctrl_14[7:0]),
     .r_aib_csr_ctrl_15                                 (r_aib_csr_ctrl_15[7:0]),
     .r_aib_csr_ctrl_16                                 (r_aib_csr_ctrl_16[7:0]),
     .r_aib_csr_ctrl_17                                 (r_aib_csr_ctrl_17[7:0]),
     .r_aib_csr_ctrl_18                                 (r_aib_csr_ctrl_18[7:0]),
     .r_aib_csr_ctrl_19                                 (r_aib_csr_ctrl_19[7:0]),
     .r_aib_csr_ctrl_2                                  (r_aib_csr_ctrl_2[7:0]),
     .r_aib_csr_ctrl_20                                 (r_aib_csr_ctrl_20[7:0]),
     .r_aib_csr_ctrl_21                                 (r_aib_csr_ctrl_21[7:0]),
     .r_aib_csr_ctrl_22                                 (r_aib_csr_ctrl_22[7:0]),
     .r_aib_csr_ctrl_23                                 (r_aib_csr_ctrl_23[7:0]),
     .r_aib_csr_ctrl_24                                 (r_aib_csr_ctrl_24[7:0]),
     .r_aib_csr_ctrl_25                                 (r_aib_csr_ctrl_25[7:0]),
     .r_aib_csr_ctrl_26                                 (r_aib_csr_ctrl_26[7:0]),
     .r_aib_csr_ctrl_27                                 (r_aib_csr_ctrl_27[7:0]),
     .r_aib_csr_ctrl_28                                 (r_aib_csr_ctrl_28[7:0]),
     .r_aib_csr_ctrl_29                                 (r_aib_csr_ctrl_29[7:0]),
     .r_aib_csr_ctrl_3                                  (r_aib_csr_ctrl_3[7:0]),
     .r_aib_csr_ctrl_30                                 (r_aib_csr_ctrl_30[7:0]),
     .r_aib_csr_ctrl_31                                 (r_aib_csr_ctrl_31[7:0]),
     .r_aib_csr_ctrl_32                                 (r_aib_csr_ctrl_32[7:0]),
     .r_aib_csr_ctrl_33                                 (r_aib_csr_ctrl_33[7:0]),
     .r_aib_csr_ctrl_34                                 (r_aib_csr_ctrl_34[7:0]),
     .r_aib_csr_ctrl_35                                 (r_aib_csr_ctrl_35[7:0]),
     .r_aib_csr_ctrl_36                                 (r_aib_csr_ctrl_36[7:0]),
     .r_aib_csr_ctrl_37                                 (r_aib_csr_ctrl_37[7:0]),
     .r_aib_csr_ctrl_38                                 (r_aib_csr_ctrl_38[7:0]),
     .r_aib_csr_ctrl_39                                 (r_aib_csr_ctrl_39[7:0]),
     .r_aib_csr_ctrl_4                                  (r_aib_csr_ctrl_4[7:0]),
     .r_aib_csr_ctrl_40                                 (r_aib_csr_ctrl_40[7:0]),
     .r_aib_csr_ctrl_41                                 (r_aib_csr_ctrl_41[7:0]),
     .r_aib_csr_ctrl_42                                 (r_aib_csr_ctrl_42[7:0]),
     .r_aib_csr_ctrl_43                                 (r_aib_csr_ctrl_43[7:0]),
     .r_aib_csr_ctrl_44                                 (r_aib_csr_ctrl_44[7:0]),
     .r_aib_csr_ctrl_45                                 (r_aib_csr_ctrl_45[7:0]),
     .r_aib_csr_ctrl_46                                 (r_aib_csr_ctrl_46[7:0]),
     .r_aib_csr_ctrl_47                                 (r_aib_csr_ctrl_47[7:0]),
     .r_aib_csr_ctrl_48                                 (r_aib_csr_ctrl_48[7:0]),
     .r_aib_csr_ctrl_49                                 (r_aib_csr_ctrl_49[7:0]),
     .r_aib_csr_ctrl_5                                  (r_aib_csr_ctrl_5[7:0]),
     .r_aib_csr_ctrl_50                                 (r_aib_csr_ctrl_50[7:0]),
     .r_aib_csr_ctrl_51                                 (r_aib_csr_ctrl_51[7:0]),
     .r_aib_csr_ctrl_52                                 (r_aib_csr_ctrl_52[7:0]),
     .r_aib_csr_ctrl_53                                 (r_aib_csr_ctrl_53[7:0]),
     .r_aib_csr_ctrl_6                                  (r_aib_csr_ctrl_6[7:0]),
     .r_aib_csr_ctrl_7                                  (r_aib_csr_ctrl_7[7:0]),
     .r_aib_csr_ctrl_8                                  (r_aib_csr_ctrl_8[7:0]),
     .r_aib_csr_ctrl_9                                  (r_aib_csr_ctrl_9[7:0]),
     .r_aib_dprio_ctrl_0                                (r_aib_dprio_ctrl_0[7:0]),
     .r_aib_dprio_ctrl_1                                (r_aib_dprio_ctrl_1[7:0]),
     .r_aib_dprio_ctrl_2                                (r_aib_dprio_ctrl_2[7:0]),
     .r_aib_dprio_ctrl_3                                (r_aib_dprio_ctrl_3[7:0]),
     .r_aib_dprio_ctrl_4                                (r_aib_dprio_ctrl_4[7:0]),
     .r_ifctl_usr_active                                (r_ifctl_usr_active),
     .r_tx_qpi_sr_enable                                (),
     .r_tx_usertest_sel                                 (),
     .r_tx_latency_src_xcvrif                           (),
     .r_avmm_testbus_sel                                (r_avmm_testbus_sel),
     .r_avmm2_avmm_clk_dcg_en                           (r_avmm2_avmm_clk_dcg_en),
     .r_avmm2_avmm_clk_scg_en                           (r_avmm2_avmm_clk_scg_en),
     .r_avmm2_free_run_div_clk                          (r_avmm2_free_run_div_clk),
     .r_avmm2_hip_sel                                   (r_avmm2_hip_sel),
     .r_avmm2_osc_clk_scg_en                            (r_avmm2_osc_clk_scg_en),
     .r_avmm2_rdfifo_empty                              (r_avmm2_rdfifo_empty[5:0]),
     .r_avmm2_rdfifo_full                               (r_avmm2_rdfifo_full[5:0]),
     .r_avmm2_rdfifo_stop_read                          (r_avmm2_rdfifo_stop_read),
     .r_avmm2_rdfifo_stop_write                         (r_avmm2_rdfifo_stop_write),
     .r_avmm_hrdrst_osc_clk_scg_en                      (r_avmm_hrdrst_osc_clk_scg_en),
     .r_rstctl_tx_elane_ovrval                          (),
     .r_rstctl_tx_elane_ovren                           (),
     .r_rstctl_rx_elane_ovrval                          (),
     .r_rstctl_rx_elane_ovren                           (),
     .r_rstctl_tx_xcvrif_ovrval                         (),
     .r_rstctl_tx_xcvrif_ovren                          (),
     .r_rstctl_rx_xcvrif_ovrval                         (),
     .r_rstctl_rx_xcvrif_ovren                          (),
     .r_rstctl_tx_adpt_ovrval                           (),
     .r_rstctl_tx_adpt_ovren                            (),
     .r_rstctl_rx_adpt_ovrval                           (),
     .r_rstctl_rx_adpt_ovren                            (),
     .r_rstctl_tx_pld_div2_rst_opt                      (),
     .r_sr_parity_en                                    (),
     .r_rx_pld_8g_a1a2_k1k2_flag_polling_bypass         (),
     .r_rx_10g_krfec_rx_diag_data_status_polling_bypass (),
     .r_rx_pld_8g_wa_boundary_polling_bypass            (),
     .r_rx_pcspma_testbus_sel                           (),
     .r_rx_pld_pma_pcie_sw_done_polling_bypass          (),
     .r_rx_pld_pma_reser_in_polling_bypass              (),
     .r_rx_pld_pma_testbus_polling_bypass               (),
     .r_rx_pld_test_data_polling_bypass                 (),
     .r_rx_align_del                                    (),
     .r_rx_async_pld_10g_rx_crc32_err_rst_val           (),
     .r_rx_async_pld_8g_signal_detect_out_rst_val       (),
     .r_rx_async_pld_ltr_rst_val                        (),
     .r_rx_async_pld_pma_ltd_b_rst_val                  (),
     .r_rx_async_pld_rx_fifo_align_clr_rst_val          (),
     .r_rx_async_hip_en                                 (),
     .r_rx_parity_sel                                   (),
     .r_rx_bonding_dft_in_en                            (),
     .r_rx_bonding_dft_in_value                         (),
     .r_rx_asn_en                                       (),
     .r_rx_slv_asn_en                                   (),
     .r_rx_asn_bypass_clock_gate                        (),
     .r_rx_asn_bypass_pma_pcie_sw_done                  (),
     .r_rx_hrdrst_user_ctl_en                           (),
     .r_rx_asn_wait_for_fifo_flush_cnt                  (),
     .r_rx_usertest_sel                                 (),
     .r_rx_internal_clk1_sel0                           (),
     .r_rx_internal_clk1_sel1                           (),
     .r_rx_internal_clk1_sel2                           (),
     .r_rx_internal_clk1_sel3                           (),
     .r_rx_txfiford_pre_ct_sel                          (),
     .r_rx_txfiford_post_ct_sel                         (),
     .r_rx_txfifowr_post_ct_sel                         (),
     .r_rx_txfifowr_from_aib_sel                        (),
     .r_rx_internal_clk2_sel0                           (),
     .r_rx_internal_clk2_sel1                           (),
     .r_rx_internal_clk2_sel2                           (),
     .r_rx_internal_clk2_sel3                           (),
     .r_rx_rxfifowr_pre_ct_sel                          (),
     .r_rx_rxfifowr_post_ct_sel                         (),
     .r_rx_rxfiford_post_ct_sel                         (),
     .r_rx_rxfiford_to_aib_sel                          (),
     .r_rx_chnl_datapath_map_mode                       (),
     .r_rx_pcs_testbus_sel                              (),
     .r_rx_comp_cnt                                     (),
     .r_rx_compin_sel                                   (),
     .r_rx_double_write                                 (r_rx_double_write),
     .r_rx_ds_bypass_pipeln                             (),
     .r_rx_ds_master                                    (),
     .r_rx_dyn_clk_sw_en                                (),
     .r_rx_fifo_empty                                   (),
     .r_rx_fifo_full                                    (),
     .r_rx_fifo_mode                                    (r_rx_fifo_mode[1:0]),
     .r_rx_fifo_pempty                                  (),
     .r_rx_fifo_pfull                                   (),
     .r_rx_fifo_rd_clk_scg_en                           (),
     .r_rx_fifo_rd_clk_sel                              (),
     .r_rx_fifo_wr_clk_scg_en                           (),
     .r_rx_fifo_wr_clk_sel                              (),
     .r_rx_pma_coreclkin_sel                            (),
     .r_rx_force_align                                  (),
     .r_rx_free_run_div_clk                             (),
     .r_rx_indv                                         (),
     .r_rx_internal_clk1_sel                            (),
     .r_rx_internal_clk2_sel                            (),
     .r_rx_mask_del                                     (),
     .r_rx_osc_clk_scg_en                               (),
     .r_rx_phcomp_rd_delay                              (r_rx_phcomp_rd_delay[2:0]),
     .r_rx_pma_hclk_scg_en                              (),
     .r_rx_stop_read                                    (),
     .r_rx_txeq_en                                      (),
     .r_rx_rxeq_en                                      (),
     .r_rx_pre_cursor_en                                (),
     .r_rx_post_cursor_en                               (),
     .r_rx_invalid_no_change                            (),
     .r_rx_adp_go_b4txeq_en                             (),
     .r_rx_use_rxvalid_for_rxeq                         (),
     .r_rx_pma_rstn_en                                  (),
     .r_rx_pma_rstn_cycles                              (),

     .r_rx_txeq_time                                    (),
     .r_rx_eq_iteration                                 (),
     .r_rx_stop_write                                   (),
     .r_rx_us_bypass_pipeln                             (),
     .r_rx_us_master                                    (),
     .r_rx_wm_en                                        (r_rx_wm_en),
     .r_rx_fifo_power_mode                              (),
     .r_rx_stretch_num_stages                           (),
     .r_rx_datapath_tb_sel                              (),
     .r_rx_wr_adj_en                                    (r_rx_wr_adj_en),
     .r_rx_rd_adj_en                                    (r_rx_rd_adj_en),
     .r_rx_msb_rdptr_pipe_byp                           (),
     .r_rx_adapter_lpbk_mode                            (r_tx_adapter_lpbk_mode),
     .r_rx_aib_lpbk_en                                  (r_rx_aib_lpbk_en),
     .r_rx_hrdrst_rst_sm_dis                            (),
     .r_rx_hrdrst_dcd_cal_done_bypass                   (),
     .r_rx_rmfflag_stretch_enable                       (),
     .r_rx_rmfflag_stretch_num_stages                   (),
     .r_rx_hrdrst_rx_osc_clk_scg_en                     (),
     .r_sr_hip_en                                       (),
     .r_sr_reserbits_in_en                              (),
     .r_sr_reserbits_out_en                             (),
     .r_sr_osc_clk_scg_en                               (),
     .r_sr_osc_clk_div_sel                              (),
     .r_sr_free_run_div_clk                             (),
     .r_sr_test_enable                                  (),
     .r_tx_aib_clk_sel                                  (),
     .r_tx_async_hip_aib_fsr_in_bit0_rst_val            (),
     .r_tx_async_hip_aib_fsr_in_bit1_rst_val            (),
     .r_tx_async_hip_aib_fsr_in_bit2_rst_val            (),
     .r_tx_async_hip_aib_fsr_in_bit3_rst_val            (),
     .r_tx_async_hip_aib_fsr_out_bit0_rst_val           (),
     .r_tx_async_hip_aib_fsr_out_bit1_rst_val           (),
     .r_tx_async_hip_aib_fsr_out_bit2_rst_val           (),
     .r_tx_async_hip_aib_fsr_out_bit3_rst_val           (),
     .r_tx_async_pld_pmaif_mask_tx_pll_rst_val          (),
     .r_tx_async_pld_txelecidle_rst_val                 (),
     .r_tx_bonding_dft_in_en                            (),
     .r_tx_bonding_dft_in_value                         (),
     .r_tx_chnl_datapath_map_mode                       (),
     .r_tx_chnl_datapath_map_rxqpi_pullup_init_val      (),
     .r_tx_chnl_datapath_map_txqpi_pulldn_init_val      (),
     .r_tx_chnl_datapath_map_txqpi_pullup_init_val      (),
     .r_tx_comp_cnt                                     (),
     .r_tx_compin_sel                                   (),
     .r_tx_double_read                                  (r_tx_double_read),
     .r_tx_ds_bypass_pipeln                             (),
     .r_tx_ds_master                                    (),
     .r_tx_dyn_clk_sw_en                                (),
     .r_tx_fifo_empty                                   (),
     .r_tx_fifo_full                                    (),
     .r_tx_fifo_mode                                    (),
     .r_tx_fifo_pempty                                  (),
     .r_tx_fifo_pfull                                   (),
     .r_tx_fifo_rd_clk_scg_en                           (),
     .r_tx_fifo_rd_clk_sel                              (r_tx_fifo_rd_clk_sel),
     .r_tx_fifo_wr_clk_scg_en                           (),
     .r_tx_free_run_div_clk                             (),
     .r_tx_indv                                         (),
     .r_tx_osc_clk_scg_en                               (),
     .r_tx_phcomp_rd_delay                              (r_tx_phcomp_rd_delay[2:0]),
     .r_tx_stop_read                                    (),
     .r_tx_stop_write                                   (),
     .r_tx_us_bypass_pipeln                             (),
     .r_tx_us_master                                    (),
     .r_tx_wa_en                                        (r_tx_wa_en),
     .r_tx_wren_fastbond                                (),
     .r_tx_fifo_power_mode                              (r_tx_fifo_mode[1:0]),
     .r_tx_stretch_num_stages                           (),
     .r_tx_datapath_tb_sel                              (),
     .r_tx_wr_adj_en                                    (r_tx_wr_adj_en),
     .r_tx_rd_adj_en                                    (r_tx_rd_adj_en),
     .r_tx_dv_gating_en                                 (),
     .r_tx_rev_lpbk                                     (r_rx_lpbk),
     .r_tx_hrdrst_rst_sm_dis                            (),
     .r_tx_hrdrst_dcd_cal_done_bypass                   (),
     .r_tx_hrdrst_dll_lock_bypass                       (),
     .r_tx_hrdrst_align_bypass                          (),
     .r_tx_hrdrst_user_ctl_en                           (),
     .r_tx_presethint_bypass                            (),
     .r_tx_hrdrst_rx_osc_clk_scg_en                     (),
     .r_tx_hip_osc_clk_scg_en                           (),
     .rx_chnl_dprio_status_write_en                     (),
     .sr_dprio_status_write_en                          (),
     .tx_chnl_dprio_status_write_en                     (),
     .r_rx_txeq_rst_sel                                 (),
     .r_rx_txeq_clk_sel                                 (),
     .r_rx_txeq_clk_scg_en                              (),
     .r_tx_ds_last_chnl                                 (),
     .r_tx_us_last_chnl                                 (),
     .r_rx_ds_last_chnl                                 (),
     .r_rx_us_last_chnl                                 (),
     .r_rx_asn_wait_for_dll_reset_cnt                   (),
     .r_rx_asn_wait_for_clock_gate_cnt                  (),
     .r_rx_asn_wait_for_pma_pcie_sw_done_cnt            (),
     // Inputs
     .tst_tcm_ctrl                                      (avmm1_tst_tcm_ctrl),
     .test_clk                                          (avmm1_test_clk),
     .scan_clk                                          (avmm1_scan_clk),
     .dft_adpt_rst                                      (1'b0),
     .scan_rst_n                                        (scan_rst_n),
     .scan_mode_n                                       (scan_mode_n),
     .aib_hssi_avmm1_data_in                            (aib_hssi_avmm1_data_in[1:0]),
     .sr_clock_tx_osc_clk_or_clkdiv                     (sr_clock_tx_osc_clk_or_clkdiv),
     .aib_hssi_rx_sr_clk_in                             (aib_hssi_rx_sr_clk_in),                 //FIX ME
     .sr_clock_aib_rx_sr_clk                            (sr_clock_aib_rx_sr_clk),                // clock aib_hssi_rx_sr_clk_in after shared TCM

     .avmm1_async_hssi_fabric_ssr_load                  (avmm1_async_hssi_fabric_ssr_load),
     .csr_rdy_dly_in                                    (csr_rdy_dly_in),
     // AVMM signals from CRSSM
     .cfg_avmm_clk                                      (w_cfg_amm_clk),
     .cfg_avmm_rst_n                                    (avmm_reset_cfg_avmm_rst_n),
     .cfg_avmm_raw_rst_n                                (cfg_avmm_raw_rst_n),
     .cfg_avmm_write                                    (cfg_avmm_slave_write),
     .cfg_avmm_read                                     (cfg_avmm_slave_read),
     .cfg_avmm_addr                                     (cfg_avmm_addr),
     .cfg_avmm_wdata                                    (cfg_avmm_wdata),
     .cfg_avmm_byte_en                                  (cfg_avmm_byte_en),
     .cfg_avmm_addr_id                                  (cfg_avmm_addr_id),
     .pld_chnl_cal_done                                 (pld_chnl_cal_done),
     .rx_chnl_dprio_status                              (rx_chnl_dprio_status[7:0]),
     .rx_chnl_dprio_status_write_en_ack                 (rx_chnl_dprio_status_write_en_ack),
     .sr_dprio_status                                   (sr_dprio_status[7:0]),
     .sr_dprio_status_write_en_ack                      (sr_dprio_status_write_en_ack),
     .tx_chnl_dprio_status                              (tx_chnl_dprio_status[7:0]),
     .tx_chnl_dprio_status_write_en_ack                 (tx_chnl_dprio_status_write_en_ack));

c3aibadapt_hrdrst_rstctrl hrdrst_rstctrl (/*AUTOINST*/
     // Outputs
     .hard_rst_out_n                     (o_hard_rst_n),
     .usermode_out                       (),
     .avmm_reset_hrdrst_rx_osc_clk_rst_n (avmm_reset_hrdrst_rx_osc_clk_rst_n),
     .avmm_reset_hrdrst_tx_osc_clk_rst_n (avmm_reset_hrdrst_tx_osc_clk_rst_n),
     .avmm_hrdrst_hssi_osc_transfer_en   (avmm_hrdrst_hssi_osc_transfer_en),
     .avmm_hrdrst_hssi_osc_transfer_alive(),
     .avmm_hrdrst_testbus                (avmm_hrdrst_testbus),
     .avmm_hrdrst_tb_direct              (avmm_hrdrst_tb_direct[2:0]),
     .avmm_reset_cfg_avmm_rst_n          (avmm_reset_cfg_avmm_rst_n),
     .cfg_avmm_raw_rst_n                 (cfg_avmm_raw_rst_n),
     // Inputs
     .dft_adpt_rst                       (1'b0),
     .adapter_scan_rst_n                 (scan_rst_n),
     .adapter_scan_mode_n                (scan_mode_n),
     .cfg_avmm_clk                       (w_cfg_amm_clk),
     .avmm_clock_hrdrst_rx_osc_clk       (avmm_clock_hrdrst_rx_osc_clk),
     .avmm_clock_reset_hrdrst_rx_osc_clk (avmm_clock_reset_hrdrst_rx_osc_clk),
     .avmm_clock_reset_hrdrst_tx_osc_clk (avmm_clock_reset_hrdrst_tx_osc_clk),
     .sr_fabric_osc_transfer_en          (sr_fabric_osc_transfer_en),
     .cfg_avmm_rst_n                     (cfg_avmm_rst_n),
     .hard_rst_n                         (csr_rdy_dly_in),
     .usermode_in                        (usermode_in));

c3aibadapt_hrdrst_clkctl hrdrst_clkctl (/*AUTOINST*/
     // Outputs
     .cfg_avmm_clk_out                   (w_cfg_amm_clk),
     .avmm_clock_hrdrst_rx_osc_clk       (avmm_clock_hrdrst_rx_osc_clk),
     .avmm_clock_hrdrst_tx_osc_clk       (avmm_clock_hrdrst_tx_osc_clk),
     .avmm_clock_reset_hrdrst_rx_osc_clk (avmm_clock_reset_hrdrst_rx_osc_clk),
     .avmm_clock_reset_hrdrst_tx_osc_clk (avmm_clock_reset_hrdrst_tx_osc_clk),
     // Inputs
     // .tst_tcm_ctrl                       (tst_tcm_ctrl),
     // .test_clk                           (test_clk),
     // .scan_clk                           (scan_clk),
     .scan_mode_n                        (scan_mode_n),
     .cfg_avmm_clk                       (cfg_avmm_clk),
     .sr_clock_aib_rx_sr_clk             (sr_clock_aib_rx_sr_clk),
     .sr_clock_tx_osc_clk_or_clkdiv      (sr_clock_tx_osc_clk_or_clkdiv),
     .r_avmm_hrdrst_osc_clk_scg_en       (r_avmm_hrdrst_osc_clk_scg_en));

c3aibadapt_avmm_async avmm_async (
     // input
     .avmm_clock_hrdrst_tx_osc_clk                 (avmm_clock_hrdrst_tx_osc_clk),
     .avmm_reset_hrdrst_tx_osc_clk_rst_n           (avmm_reset_hrdrst_tx_osc_clk_rst_n),
     .avmm_clock_hrdrst_rx_osc_clk                 (avmm_clock_hrdrst_rx_osc_clk),
     .avmm_reset_hrdrst_rx_osc_clk_rst_n           (avmm_reset_hrdrst_rx_osc_clk_rst_n),
     .avmm_async_fabric_hssi_ssr_load              (avmm_async_fabric_hssi_ssr_load),
     .avmm_hrdrst_fabric_osc_transfer_en_ssr_data  (avmm_hrdrst_fabric_osc_transfer_en_ssr_data),
     .avmm_async_hssi_fabric_ssr_load              (avmm_async_hssi_fabric_ssr_load),
     .avmm_hrdrst_hssi_osc_transfer_en             (avmm_hrdrst_hssi_osc_transfer_en),
     // output
     .avmm_hrdrst_hssi_osc_transfer_en_sync        (),
     .avmm_hrdrst_hssi_osc_transfer_en_ssr_data    (),
     .sr_fabric_osc_transfer_en                    (sr_fabric_osc_transfer_en)
     );

endmodule
