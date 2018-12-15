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
	 input [31:0] DEV1_RD, DEV2_RD,
	 output DEV1_WE, DEV2_WE
    );

assign DEV_WD = PrWD;
assign DEV_Addr = PrAddr;

assign PrRd = PrAddr[15:4] == 12'h7F0 ? DEV1_RD : 
				  PrAddr[15:4] == 12'h7F1 ? DEV2_RD : 
				  32'bx;

assign DEV1_WE = PrWE && (PrAddr[15:4] == 12'h7F0) ? 1 : 0;
assign DEV2_WE = PrWE && (PrAddr[15:4] == 12'h7F1) ? 1 : 0;

endmodule
