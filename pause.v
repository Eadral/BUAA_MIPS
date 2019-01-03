`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:11:52 11/24/2018 
// Design Name: 
// Module Name:    pause 
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
`include "macro.v"

module pause(
	 input [1:0] Tuse_Rs_D, Tuse_Rt_D,
	 input [1:0] Tnew_E, Tnew_M, Tnew_W,

	 input [31:0] IR_D, IR_E, IR_M, IR_W,
	 
	 input GRF_WE_E, GRF_WE_M, GRF_WE_W,
	 input CP0_WE_E, CP0_WE_M, 
	 
	 input [4:0] A3_E, A3_M, A3_W,
	 
	 input DM_WE_D,
	 input [1:0] WDsel_E,
	 input DM_RE_E,
	 input [1:0] WDsel_M,
	 input DM_RE_M,
	 
	 input [1:0] NPCsel_D,
	 
	 input IntReq,
	 
    output pause
    );

wire eret = 
				(IR_D == `eret && CP0_WE_E && IR_E[`Rd] == 14) ||
				(IR_D == `eret && CP0_WE_M && IR_M[`Rd] == 14) 
				;

wire stall_Rs = 
					((IR_D[`Rs] == A3_E) && (A3_E != 0) && (GRF_WE_E) && (Tuse_Rs_D < Tnew_E)) ||
					((IR_D[`Rs] == A3_M) && (A3_M != 0) && (GRF_WE_M) && (Tuse_Rs_D < Tnew_M)) ||
					((IR_D[`Rs] == A3_W) && (A3_W != 0) && (GRF_WE_W) && (Tuse_Rs_D < Tnew_W)) ;
					
wire stall_Rt = 
					((IR_D[`Rt] == A3_E) && (A3_E != 0) && (GRF_WE_E) && (Tuse_Rt_D < Tnew_E)) ||
					((IR_D[`Rt] == A3_M) && (A3_M != 0) && (GRF_WE_M) && (Tuse_Rt_D < Tnew_M)) ||
					((IR_D[`Rt] == A3_W) && (A3_W != 0) && (GRF_WE_W) && (Tuse_Rt_D < Tnew_W)) ;

assign pause = !(IntReq === 1) && (eret === 1 || stall_Rs === 1 || stall_Rt === 1);

endmodule
