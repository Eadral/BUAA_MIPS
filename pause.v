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
`define Op 31:26
`define Rs 25:21
`define Rt 20:16
`define Rd 15:11
`define Shamt 10:6
`define Func 5:0

`define Imm 15:0
`define Addr 25:0

module pause(
	 input [31:0] IR_D,
	 input [31:0] IR_E,
	 input [31:0] IR_M,
	 
	 input DM_WE_D,
	 input [1:0] WDsel_E,
	 input DM_RE_E,
	 input [1:0] WDsel_M,
	 input DM_RE_M,
	 input [1:0] A3sel_E,
	 input GRF_WE_E,
	 input [1:0] NPCsel_D,
	 
    output reg pause
    );

reg lw_r, lw_b, lw_sw, lw_o, rd_bj, rd_jr, rt_bj, rt_jr, jal_bj, jal_jr, lw_b_m, lw_j_m;

always @(*) begin
	//E
	lw_r = (DM_RE_E && IR_D[`Op] == 6'b0) && ((IR_D[`Rs] == IR_E[`Rt]) || (IR_D[`Rt] == IR_E[`Rt])) && (IR_E[`Rt] != 32'b0);
	lw_b = (DM_RE_E && NPCsel_D == 2'b01) && ((IR_D[`Rs] == IR_E[`Rt]) || (IR_D[`Rt] == IR_E[`Rt])) && (IR_E[`Rt] != 32'b0);
	lw_sw = 0;
		//(DM_RE_E && DM_WE_D) && ((IR_D[`Rs] == IR_E[`Rt]) || (IR_D[`Rt] == IR_E[`Rt])) && (IR_E[`Rt] != 32'b0);
	lw_o = (DM_RE_E ) && ((IR_D[`Rs] == IR_E[`Rt]) ) && (IR_E[`Rt] != 32'b0);
	// DANGEROUS! add rt may repair new bugs

	rd_bj = (GRF_WE_E && A3sel_E == 2'b00 && NPCsel_D == 2'b01) && ((IR_D[`Rs] == IR_E[`Rd]) || (IR_D[`Rt] == IR_E[`Rd])) && (IR_E[`Rd] != 32'b0);
	rd_jr = (GRF_WE_E && A3sel_E == 2'b00 && NPCsel_D == 2'b10) && ((IR_D[`Rs] == IR_E[`Rd]) ) && (IR_E[`Rd] != 32'b0);
	rt_bj = (GRF_WE_E && A3sel_E == 2'b01 && NPCsel_D == 2'b01) && ((IR_D[`Rs] == IR_E[`Rt]) || (IR_D[`Rt] == IR_E[`Rt])) && (IR_E[`Rt] != 32'b0);
	rt_jr = (GRF_WE_E && A3sel_E == 2'b01 && NPCsel_D == 2'b10) && ((IR_D[`Rs] == IR_E[`Rt]) ) && (IR_E[`Rt] != 32'b0);
	//jal_bj = (GRF_WE_E && A3sel_E == 2'b11 && NPCsel_D == 2'b01) && ((IR_D[`Rs] == 5'd31) || (IR_D[`Rt] == 5'd31));
	//jal_jr = (GRF_WE_E && A3sel_E == 2'b11 && NPCsel_D == 2'b10) && ((IR_D[`Rs] == 5'd31) );
	jal_bj = 0;  // forward
	jal_jr = 0;  // forward
	
	//M
	lw_b_m = (DM_RE_M && NPCsel_D == 2'b01) && ((IR_D[`Rs] == IR_M[`Rt]) || (IR_D[`Rt] == IR_M[`Rt])) && (IR_M[`Rt] != 32'b0);
	lw_j_m = (DM_RE_M && NPCsel_D == 2'b10) && ((IR_D[`Rs] == IR_M[`Rt]) ) && (IR_M[`Rt] != 32'b0);
	
	pause = (lw_r === 1 || lw_b === 1 || lw_sw || lw_o === 1 || 
			  rd_bj === 1 || rd_jr === 1 | rt_bj === 1 || 
			  rt_jr === 1 || lw_b_m === 1 || lw_j_m === 1)
		&& !(IR_D[`Op] == 6'b000000 && IR_D[`Func] == 6'b000010)  // j 
		
		&& !(IR_M == 32'b0 && IR_E == 32'b0) // stall more than twice
			  
			  ;
end

endmodule
