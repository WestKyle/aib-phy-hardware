// SPDX-License-Identifier: Apache-2.0
// Copyright (C) 2019 Intel Corporation. 

//---------------------------------------------------------------------------------------------------------------------------------------------
//  io_cmos_nand_x128
//---------------------------------------------------------------------------------------------------------------------------------------------

module io_cmos_nand_x128 (
input         in_p,
input         in_n,
input   [6:0] gray,
output        out_p,
output        out_n
);

`ifdef TIMESCALE_EN
                timeunit 1ps;
                timeprecision 1ps;
`endif

parameter   NAND_DELAY = 20;

wire [127:0]  bk;
wire [125:0]  a;
wire [124:0]  b;
wire [125:0]  c;
wire [124:0]  d;

io_cmos_nand_x128_decode xdec (
.gray	    ( gray[6:0]		),
.bk	    ( bk[127:0]		)
);

io_cmos_nand_x6 xnand_x6 [20:0] (
.in_p       ( {a[119],a[113],a[107],a[101],a[95],a[89],a[83],a[77],a[71],a[65],a[59],a[53],a[47],a[41],a[35],a[29],a[23],a[17],a[11],a[5],in_p}       ),
.in_n       ( {c[119],c[113],c[107],c[101],c[95],c[89],c[83],c[77],c[71],c[65],c[59],c[53],c[47],c[41],c[35],c[29],c[23],c[17],c[11],c[5],in_n}       ),
.bk5        ( {1'b0,bk[119],bk[113],bk[107],bk[101],bk[95],bk[89],bk[83],bk[77],bk[71],bk[65],bk[59],bk[53],bk[47],bk[41],bk[35],bk[29],bk[23],bk[17],bk[11],bk[5]} ),
.bk4        ( {bk[124],bk[118],bk[112],bk[106],bk[100],bk[94],bk[88],bk[82],bk[76],bk[70],bk[64],bk[58],bk[52],bk[46],bk[40],bk[34],bk[28],bk[22],bk[16],bk[10],bk[4]} ),
.bk3        ( {bk[123],bk[117],bk[111],bk[105],bk[99],bk[93],bk[87],bk[81],bk[75],bk[69],bk[63],bk[57],bk[51],bk[45],bk[39],bk[33],bk[27],bk[21],bk[15],bk[9],bk[3]}  ),
.bk2        ( {bk[122],bk[116],bk[110],bk[104],bk[98],bk[92],bk[86],bk[80],bk[74],bk[68],bk[62],bk[56],bk[50],bk[44],bk[38],bk[32],bk[26],bk[20],bk[14],bk[8],bk[2]}  ),
.bk1        ( {bk[121],bk[115],bk[109],bk[103],bk[97],bk[91],bk[85],bk[79],bk[73],bk[67],bk[61],bk[55],bk[49],bk[43],bk[37],bk[31],bk[25],bk[19],bk[13],bk[7],bk[1]}  ),
.bk0        ( {bk[120],bk[114],bk[108],bk[102],bk[96],bk[90],bk[84],bk[78],bk[72],bk[66],bk[60],bk[54],bk[48],bk[42],bk[36],bk[30],bk[24],bk[18],bk[12],bk[6],bk[0]}  ),
.ci_p       ( {1'b1,b[119],b[113],b[107],b[101],b[95],b[89],b[83],b[77],b[71],b[65],b[59],b[53],b[47],b[41],b[35],b[29],b[23],b[17],b[11],b[5]}       ),
.ci_n       ( {1'b1,d[119],d[113],d[107],d[101],d[95],d[89],d[83],d[77],d[71],d[65],d[59],d[53],d[47],d[41],d[35],d[29],d[23],d[17],d[11],d[5]}       ),
.out_p      ( {b[119],b[113],b[107],b[101],b[95],b[89],b[83],b[77],b[71],b[65],b[59],b[53],b[47],b[41],b[35],b[29],b[23],b[17],b[11],b[5],out_p}      ),
.out_n      ( {d[119],d[113],d[107],d[101],d[95],d[89],d[83],d[77],d[71],d[65],d[59],d[53],d[47],d[41],d[35],d[29],d[23],d[17],d[11],d[5],out_n}      ),
.co_p       ( {a[125],a[119],a[113],a[107],a[101],a[95],a[89],a[83],a[77],a[71],a[65],a[59],a[53],a[47],a[41],a[35],a[29],a[23],a[17],a[11],a[5]}     ),
.co_n       ( {c[125],c[119],c[113],c[107],c[101],c[95],c[89],c[83],c[77],c[71],c[65],c[59],c[53],c[47],c[41],c[35],c[29],c[23],c[17],c[11],c[5]}     )
);

endmodule



