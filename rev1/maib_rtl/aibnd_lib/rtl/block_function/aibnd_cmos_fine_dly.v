// SPDX-License-Identifier: Apache-2.0
// Copyright (C) 2019 Intel Corporation. 

//---------------------------------------------------------------------------------------------------------------------------------------------
//  aibnd_cmos_fine_dly
//---------------------------------------------------------------------------------------------------------------------------------------------

module aibnd_cmos_fine_dly (
input	      vcc_aibnd, vss_aibnd, vcc_io,
input   [2:0] gray,
input         ck, fout_p, nrst, se_n, si, code_valid,
output        so, out_p
);

`ifdef TIMESCALE_EN
		timeunit 1ps; 
		timeprecision 1ps; 
`endif

wire pg0,ng0,pg1,ng1,pg2,ng2;
wire sp0,sn0,sp1,sn1,sp2,sn2,sp3,sn3,sp4,sn4,sp5,sn5,sp6,sn6,sp7,sn7;
wire sp1_a,sn1_a,sp2_a,sn2_a,sp3_a,sn3_a,sp4_a,sn4_a,sp5_a,sn5_a,sp6_a,sn6_a,sp7_a,sn7_a;
wire so0,so1,so2,so3,so4,so5,so6,so7,so8,so9,so10,so11,so12;
wire sp0_a;
wire sn0_a;
integer intrinsic, step, calc_delay, total_delay;

assign ng2 = ~gray[2];
assign pg2 = gray[2];
assign ng1 = ~gray[1];
assign pg1 = gray[1];
assign ng0 = ~gray[0];
assign pg0 = gray[0];

assign sp7_a = ~(pg2&ng1&ng0);
assign sn7_a = ~sp7_a;
assign sp6_a = ~((pg2&ng1&pg0) | sn7_a);
assign sn6_a = ~sp6_a;
assign sp5_a = ~((pg2&pg1&pg0) | sn6_a);
assign sn5_a = ~sp5_a;
assign sp4_a = ~((pg2&pg1&ng0) | sn5_a);
assign sn4_a = ~sp4_a;
assign sp3_a = ~((ng2&pg1&ng0) | sn4_a);
assign sn3_a = ~sp3_a;
assign sp2_a = ~((ng2&pg1&pg0) | sn3_a);
assign sn2_a = ~sp2_a;
assign sp1_a = ~((ng2&ng1&pg0) | sn2_a);
assign sn1_a = ~sp1_a;
assign sp0_a = ~((ng2&ng1&ng0) | sn1_a);
assign sn0_a = ~sp0_a;

aibnd_str_ff x127 ( .se_n(se_n), .so(so),  .si(so12),.rb(nrst), .clk(ck), .d(sn7_a), .code_valid(code_valid), .q(sn7));
aibnd_str_ff x118 ( .se_n(se_n), .so(so0), .si(si),  .rb(nrst), .clk(ck), .d(sp1_a), .code_valid(code_valid), .q(sp1));
aibnd_str_ff x104 ( .se_n(se_n), .so(so1), .si(so0), .rb(nrst), .clk(ck), .d(sp2_a), .code_valid(code_valid), .q(sp2));
aibnd_str_ff x101 ( .se_n(se_n), .so(so2), .si(so1), .rb(nrst), .clk(ck), .d(sp3_a), .code_valid(code_valid), .q(sp3));
aibnd_str_ff x99  ( .se_n(se_n), .so(so3), .si(so2), .rb(nrst), .clk(ck), .d(sp4_a), .code_valid(code_valid), .q(sp4));
aibnd_str_ff x97  ( .se_n(se_n), .so(so4), .si(so3), .rb(nrst), .clk(ck), .d(sp5_a), .code_valid(code_valid), .q(sp5));
aibnd_str_ff x95  ( .se_n(se_n), .so(so5), .si(so4), .rb(nrst), .clk(ck), .d(sp6_a), .code_valid(code_valid), .q(sp6));
aibnd_str_ff x93  ( .se_n(se_n), .so(so6), .si(so5), .rb(nrst), .clk(ck), .d(sp7_a), .code_valid(code_valid), .q(sp7));
aibnd_str_ff x129 ( .se_n(se_n), .so(so12),.si(so11),.rb(nrst), .clk(ck), .d(sn6_a), .code_valid(code_valid), .q(sn6));
aibnd_str_ff x131 ( .se_n(se_n), .so(so11),.si(so10),.rb(nrst), .clk(ck), .d(sn5_a), .code_valid(code_valid), .q(sn5));
aibnd_str_ff x133 ( .se_n(se_n), .so(so10),.si(so9), .rb(nrst), .clk(ck), .d(sn4_a), .code_valid(code_valid), .q(sn4));
aibnd_str_ff x135 ( .se_n(se_n), .so(so9), .si(so8), .rb(nrst), .clk(ck), .d(sn3_a), .code_valid(code_valid), .q(sn3));
aibnd_str_ff x137 ( .se_n(se_n), .so(so8), .si(so7), .rb(nrst), .clk(ck), .d(sn2_a), .code_valid(code_valid), .q(sn2));
aibnd_str_ff x140 ( .se_n(se_n), .so(so7), .si(so6), .rb(nrst), .clk(ck), .d(sn1_a), .code_valid(code_valid), .q(sn1));

initial step = 32'd4;

always @(*)
	if	(sn7 == 1'b1) calc_delay = (7 * step);
        else if (sn6 == 1'b1) calc_delay = (6 * step);
        else if (sn5 == 1'b1) calc_delay = (5 * step);
        else if (sn4 == 1'b1) calc_delay = (4 * step);
        else if (sn3 == 1'b1) calc_delay = (3 * step);
        else if (sn2 == 1'b1) calc_delay = (2 * step);
        else if (sn1 == 1'b1) calc_delay = (1 * step);
        else                  calc_delay = (0 * step);

initial intrinsic = 32'd50;  //min:10ps; typ:50ps; max:80ps
//        assign delay = intrinsic  + calc_delay;
        always @(*) total_delay = intrinsic  + calc_delay;
	assign #total_delay out_p = fout_p;

endmodule



