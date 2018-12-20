`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:00 11/22/2018 
// Design Name: 
// Module Name:    mips 
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
 /**/

module mips(
    input clk,
    input reset
    );

wire [31:0] PrAddr, PrWD, PrRD, DEV_Addr, DEV_WD, DEV1_RD, DEV2_RD;
wire PrWE;
wire [7:2] HWInt;

cpu CPU(
    .clk(clk), 
    .reset(reset), 
    .PrAddr(PrAddr), 
    .PrWD(PrWD), 
    .PrRD(PrRD), 
    .PrWE(PrWE), 
    .HWInt(HWInt)
    );
	 
bridge Bridge(
    .PrAddr(PrAddr), 
    .PrWD(PrWD), 
    .PrRD(PrRD), 
	 .PrWE(PrWE),
    .DEV_Addr(DEV_Addr), 
    .DEV_WD(DEV_WD), 
    .DEV1_RD(DEV1_RD), 
    .DEV2_RD(DEV2_RD),
	 .DEV1_WE(DEV1_WE),
	 .DEV2_WE(DEV2_WE)
    );

timer Timer0(
    .ADD_I(DEV_Addr[3:0]), 
    .WE_I(DEV1_WE), 
    .DAT_I(DEV_WD), 
    .DAT_O(DEV1_RD), 
    .IRQ_O(HWInt[2]), 
    .clk(clk), 
    .reset(reset)
    );

timer Timer1(
    .ADD_I(DEV_Addr[3:0]), 
    .WE_I(DEV2_WE), 
    .DAT_I(DEV_WD), 
    .DAT_O(DEV2_RD), 
    .IRQ_O(HWInt[3]), 
    .clk(clk), 
    .reset(reset)
    );

assign HWInt[7:4] = 0;

endmodule
