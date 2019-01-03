`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:00:06 12/05/2018 
// Design Name: 
// Module Name:    bridge 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bridge(
	 input [31:0] PrAddr, PrWD,
	 output [31:0] PrRD,
	 input PrWE,
	 output [31:0] DEV_Addr, DEV_WD,
	 input [31:0] DEV1_RD, DEV2_RD, DEV3_RD, DEV4_RD, DEV5_RD, DEV6_RD,
	 output DEV1_WE, DEV2_WE, DEV3_WE, DEV4_WE, DEV5_WE, DEV6_WE,
	 output DEV2_STB
    );

assign DEV_WD = PrWD;
assign DEV_Addr = PrAddr;

assign PrRD = (PrAddr >= 32'h0000_7f00 && PrAddr <= 32'h0000_7f0b) ? DEV1_RD : 
				  (PrAddr >= 32'h0000_7f10 && PrAddr <= 32'h0000_7f2b) ? DEV2_RD : 
				  (PrAddr >= 32'h0000_7f2c && PrAddr <= 32'h0000_7f33) ? DEV3_RD : 
				  (PrAddr >= 32'h0000_7f34 && PrAddr <= 32'h0000_7f37) ? DEV4_RD : 
				  (PrAddr >= 32'h0000_7f38 && PrAddr <= 32'h0000_7f3f) ? DEV5_RD : 
				  (PrAddr >= 32'h0000_7f40 && PrAddr <= 32'h0000_7f43) ? DEV6_RD : 
				  32'bx;

assign DEV1_WE = PrWE && (PrAddr >= 32'h0000_7f00 && PrAddr <= 32'h0000_7f0b) ? 1 : 0;
assign DEV2_WE = PrWE && (PrAddr >= 32'h0000_7f10 && PrAddr <= 32'h0000_7f2b) ? 1 : 0;
assign DEV2_STB = 		 (PrAddr >= 32'h0000_7f10 && PrAddr <= 32'h0000_7f2b) ? 1 : 0;
assign DEV3_WE = PrWE && (PrAddr >= 32'h0000_7f2c && PrAddr <= 32'h0000_7f33) ? 1 : 0;
assign DEV4_WE = PrWE && (PrAddr >= 32'h0000_7f34 && PrAddr <= 32'h0000_7f37) ? 1 : 0;
assign DEV5_WE = PrWE && (PrAddr >= 32'h0000_7f38 && PrAddr <= 32'h0000_7f3f) ? 1 : 0;
assign DEV6_WE = PrWE && (PrAddr >= 32'h0000_7f40 && PrAddr <= 32'h0000_7f43) ? 1 : 0;

endmodule
