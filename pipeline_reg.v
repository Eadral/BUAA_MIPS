`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:32:34 11/23/2018 
// Design Name: 
// Module Name:    pipeline_reg 
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
module F_D_reg(
    input [31:0] IR_F,
    input [31:0] PC_F,
    input [31:0] PC8_F,
	 input Exc_F, slot_F,
	 input [4:0] ExcCode_F,
    output reg [31:0] IR_D,
    output reg [31:0] PC_D,
    output reg [31:0] PC8_D,
	 output reg Exc_D, slot_D,
	 output reg [4:0] ExcCode_D,
	 input clk,
    input stall,
	 input clr,
	 input reset
    );

always @(posedge clk) begin
	if (reset || clr) begin
		IR_D <= 32'b0;
		PC_D <= 32'b0;
		PC8_D <= 32'b0;
		Exc_D <= 0;
		slot_D <= 0;
	end else
	if (!stall) begin
		IR_D  <= IR_F ;
		PC_D <= PC_F;
		PC8_D <= PC8_F;
		Exc_D <= Exc_F;
		ExcCode_D <= ExcCode_F;
		slot_D <= slot_F;
	end

end


endmodule


//

module D_E_reg(
    input [31:0] IR_D,
    input [31:0] PC_D,
    input [31:0] PC8_D,
    input [31:0] Rs_D,
    input [31:0] Rt_D,
    input [31:0] Ext_D,
	 input [1:0] Tnew_D,
	 input Jump_D,
	 input pause_D,
	 output reg [31:0] IR_E,
	 output reg [31:0] PC_E,
	 output reg [31:0] PC8_E,
	 output reg [31:0] Rs_E,
	 output reg [31:0] Rt_E,
	 output reg [31:0] Ext_E,
	 output reg [1:0] Tnew_E,
	 output reg Jump_E,
	 output reg pause_E,
	 input Exc_D, slot_D,
	 input [4:0] ExcCode_D,
	 output reg Exc_E, slot_E,
	 output reg [4:0] ExcCode_E,
	 input clk,
	 input clr,
	 input reset,
	 
	 input [1:0] NPCsel_D,
	 input [1:0] NPCOp_D,
	 input [3:0] CMPOp_D,
	 input [1:0] ExtOp_D,
	 input [1:0] ALUasel_D,
	 input [1:0] ALUbsel_D,
	 input [3:0] ALUOp_D,
	 input DM_RE_D,
	 input DM_WE_D,
	 input [2:0] DMOOp_D, DMIOp_D,
	 input [2:0] A3sel_D,
	 input [1:0] WDsel_D,
	 input GRF_WE_D,
	 input [1:0] Tuse_Rs_D, Tuse_Rt_D,
	 input eret_D,
	 input CP0_WE_D,
	 
	 output reg [1:0] NPCsel_E,
	 output reg [1:0] NPCOp_E,
	 output reg [3:0] CMPOp_E,
	 output reg [1:0] ExtOp_E,
	 output reg [1:0] ALUasel_E,
	 output reg [1:0] ALUbsel_E,
	 output reg [3:0] ALUOp_E,
	 output reg DM_RE_E,
	 output reg DM_WE_E,
	 output reg [2:0] DMOOp_E, DMIOp_E,
	 output reg [2:0] A3sel_E,
	 output reg [1:0] WDsel_E,
	 output reg GRF_WE_E,
	 output reg [1:0] Tuse_Rs_E, Tuse_Rt_E,
	 output reg eret_E,
	 output reg CP0_WE_E
	 
    );
	

always @(posedge clk) begin
	if (reset || clr) begin
		IR_E	<= 32'b0; 
		PC_E	<= 32'b0; 
		PC8_E	<= 32'b0; 
		Rs_E	<= 32'b0; 
		Rt_E	<= 32'b0; 
		Ext_E	<= 32'b0; 
		Tnew_E <= 0;
		Jump_E <= 0;
		Exc_E <= 0;
		slot_E <= 0;
		ExcCode_E <= 0;
		pause_E <= pause_D;
		
		NPCsel_E <= 0; NPCOp_E <= 0; CMPOp_E <= 0; ExtOp_E <= 0; ALUasel_E <= 0; ALUbsel_E <= 0; ALUOp_E <= 0; DM_RE_E <= 0; DM_WE_E <= 0;
 DMOOp_E <= 0; DMIOp_E <= 0; A3sel_E <= 0; WDsel_E <= 0; GRF_WE_E <= 0; Tuse_Rs_E <= 0; Tuse_Rt_E <= 0; eret_E <= 0; CP0_WE_E <= 0;
	end else begin
		IR_E	<= IR_D; 
		PC_E	<= PC_D; 
		PC8_E	<= PC8_D; 
		Rs_E	<= Rs_D; 
		Rt_E	<= Rt_D; 
		Ext_E	<= Ext_D; 
		Jump_E <= Jump_D;
		Exc_E <= Exc_D;
		slot_E <= slot_D;
		ExcCode_E <= ExcCode_D;
		pause_E <= pause_D;
		if (Tnew_D > 0)
			Tnew_E <= Tnew_D;
		else
			Tnew_E <= 0;
			
		NPCsel_E <= NPCsel_D; NPCOp_E <= NPCOp_D; CMPOp_E <= CMPOp_D; ExtOp_E <= ExtOp_D; ALUasel_E <= ALUasel_D;
 ALUbsel_E <= ALUbsel_D; ALUOp_E <= ALUOp_D; DM_RE_E <= DM_RE_D; DM_WE_E <= DM_WE_D;
 DMOOp_E <= DMOOp_D; DMIOp_E <= DMIOp_D; A3sel_E <= A3sel_D; WDsel_E <= WDsel_D; GRF_WE_E <= GRF_WE_D; Tuse_Rs_E <= Tuse_Rs_D;
 Tuse_Rt_E <= Tuse_Rt_D; eret_E <= eret_D; CP0_WE_E <= CP0_WE_D;
	end
end

endmodule


//


module E_M_reg(
    input [31:0] IR_E,
    input [31:0] PC_E,
    input [31:0] PC8_E,
    input [31:0] ALUOut_E,
    input [31:0] Rt_E,
	 input [4:0] A3_E,
	 input [1:0] Tnew_E,
	 input Exc_E, slot_E,
	 input [4:0] ExcCode_E,
	 input pause_E,
	 output reg Exc_M, slot_M,
	 output reg [4:0] ExcCode_M,
	 output reg [31:0] IR_M,
	 output reg [31:0] PC_M,
	 output reg [31:0] PC8_M,
	 output reg [31:0] ALUOut_M,
	 output reg [31:0] Rt_M,
	 output reg [4:0] A3_M,
	 output reg [1:0] Tnew_M,
	 output reg pause_M,
	 input clk,
	 input reset,
	 
	 input [1:0] NPCsel_E,
	 input [1:0] NPCOp_E,
	 input [3:0] CMPOp_E,
	 input [1:0] ExtOp_E,
	 input [1:0] ALUasel_E,
	 input [1:0] ALUbsel_E,
	 input [3:0] ALUOp_E,
	 input DM_RE_E,
	 input DM_WE_E,
	 input [2:0] DMOOp_E, DMIOp_E,
	 input [2:0] A3sel_E,
	 input [1:0] WDsel_E,
	 input GRF_WE_E,
	 input [1:0] Tuse_Rs_E, Tuse_Rt_E,
	 input eret_E,
	 input CP0_WE_E,
	 
	 output reg [1:0] NPCsel_M,
	 output reg [1:0] NPCOp_M,
	 output reg [3:0] CMPOp_M,
	 output reg [1:0] ExtOp_M,
	 output reg [1:0] ALUasel_M,
	 output reg [1:0] ALUbsel_M,
	 output reg [3:0] ALUOp_M,
	 output reg DM_RE_M,
	 output reg DM_WE_M,
	 output reg [2:0] DMOOp_M, DMIOp_M,
	 output reg [2:0] A3sel_M,
	 output reg [1:0] WDsel_M,
	 output reg GRF_WE_M,
	 output reg [1:0] Tuse_Rs_M, Tuse_Rt_M,
	 output reg eret_M,
	 output reg CP0_WE_M
    );

always @(posedge clk) begin
	if (reset) begin
		IR_M	<= 32'b0;
		PC_M <= 32'b0;
		PC8_M <= 32'b0;
		ALUOut_M <= 32'b0;
		Rt_M <= 32'b0;
		Tnew_M <= 0;
		A3_M <= 0;
		Exc_M <= 0;
		slot_M <= 0;
		ExcCode_M <= 0;
		pause_M <= 0;
		
		NPCsel_M <= 0; NPCOp_M <= 0; CMPOp_M <= 0; ExtOp_M <= 0; ALUasel_M <= 0; ALUbsel_M <= 0; ALUOp_M <= 0; DM_RE_M <= 0; DM_WE_M <= 0;
 DMOOp_M <= 0; DMIOp_M <= 0; A3sel_M <= 0; WDsel_M <= 0; GRF_WE_M <= 0; Tuse_Rs_M <= 0; Tuse_Rt_M <= 0; eret_M <= 0; CP0_WE_M <= 0;
	end else begin
		IR_M	<= 		IR_E;
		PC_M <=       PC_E;
		PC8_M <=       PC8_E;
		ALUOut_M <=    ALUOut_E;
		Rt_M <=        Rt_E;
		A3_M <=	A3_E;
		Exc_M <= Exc_E;
		slot_M <= slot_E;
		ExcCode_M <= ExcCode_E;
		pause_M <= pause_E;
		if (Tnew_E > 0)
			Tnew_M <= Tnew_E - 1;
		else 
			Tnew_M <= 0;
			
		NPCsel_M <= NPCsel_E; NPCOp_M <= NPCOp_E; CMPOp_M <= CMPOp_E; ExtOp_M <= ExtOp_E; ALUasel_M <= ALUasel_E;
 ALUbsel_M <= ALUbsel_E; ALUOp_M <= ALUOp_E; DM_RE_M <= DM_RE_E; DM_WE_M <= DM_WE_E;
 DMOOp_M <= DMOOp_E; DMIOp_M <= DMIOp_E; A3sel_M <= A3sel_E; WDsel_M <= WDsel_E; GRF_WE_M <= GRF_WE_E; Tuse_Rs_M <= Tuse_Rs_E;
 Tuse_Rt_M <= Tuse_Rt_E; eret_M <= eret_E; CP0_WE_M <= CP0_WE_E;
	end
end


endmodule


//


module M_W_reg(
    input [31:0] IR_M,
    input [31:0] PC_M,
    input [31:0] PC8_M,
    input [31:0] ALUOut_M,
    input [31:0] DM_M,
    input [31:0] CP0_M,
	 input [4:0] A3_M,
	 input [1:0] Tnew_M,
	 output reg [31:0] IR_W,
	 output reg [31:0] PC_W,
	 output reg [31:0] PC8_W,
	 output reg [31:0] ALUOut_W,
	 output reg [31:0] DM_W,
	 output reg [31:0] CP0_W,
	 output reg [4:0] A3_W,
	 output reg [1:0] Tnew_W,
	 input clk,
	 input reset,
	 
	 input [1:0] NPCsel_M,
	 input [1:0] NPCOp_M,
	 input [3:0] CMPOp_M,
	 input [1:0] ExtOp_M,
	 input [1:0] ALUasel_M,
	 input [1:0] ALUbsel_M,
	 input [3:0] ALUOp_M,
	 input DM_RE_M,
	 input DM_WE_M,
	 input [2:0] DMOOp_M, DMIOp_M,
	 input [2:0] A3sel_M,
	 input [1:0] WDsel_M,
	 input GRF_WE_M,
	 input [1:0] Tuse_Rs_M, Tuse_Rt_M,
	 input eret_M,
	 input CP0_WE_M,
	 
	 output reg [1:0] NPCsel_W,
	 output reg [1:0] NPCOp_W,
	 output reg [3:0] CMPOp_W,
	 output reg [1:0] ExtOp_W,
	 output reg [1:0] ALUasel_W,
	 output reg [1:0] ALUbsel_W,
	 output reg [3:0] ALUOp_W,
	 output reg DM_RE_W,
	 output reg DM_WE_W,
	 output reg [2:0] DMOOp_W, DMIOp_W,
	 output reg [2:0] A3sel_W,
	 output reg [1:0] WDsel_W,
	 output reg GRF_WE_W,
	 output reg [1:0] Tuse_Rs_W, Tuse_Rt_W,
	 output reg eret_W,
	 output reg CP0_WE_W
    );


always @(posedge clk) begin
	if (reset) begin
		IR_W		<= 32'b0;
		PC_W		<= 32'b0;
		PC8_W		<= 32'b0;
		ALUOut_W	<= 32'b0;
		DM_W		<= 32'b0;
		CP0_W		<= 32'b0;
		Tnew_W	<= 0;
		A3_W		<= 0;
		
		NPCsel_W <= 0; NPCOp_W <= 0; CMPOp_W <= 0; ExtOp_W <= 0; ALUasel_W <= 0; ALUbsel_W <= 0; ALUOp_W <= 0; DM_RE_W <= 0; DM_WE_W <= 0;
 DMOOp_W <= 0; DMIOp_W <= 0; A3sel_W <= 0; WDsel_W <= 0; GRF_WE_W <= 0; Tuse_Rs_W <= 0; Tuse_Rt_W <= 0; eret_W <= 0; CP0_WE_W <= 0;
	end else begin
		IR_W		<= IR_M;
		PC_W		<= PC_M;
		PC8_W		<= PC8_M;
		ALUOut_W	<= ALUOut_M;
		DM_W		<= DM_M;
		CP0_W		<= CP0_M;
		A3_W 		<= A3_M;
		if (Tnew_M > 0)
			Tnew_W <= Tnew_M - 1;
		else 
			Tnew_W <= 0;
			
		NPCsel_W <= NPCsel_M; NPCOp_W <= NPCOp_M; CMPOp_W <= CMPOp_M; ExtOp_W <= ExtOp_M; ALUasel_W <= ALUasel_M;
 ALUbsel_W <= ALUbsel_M; ALUOp_W <= ALUOp_M; DM_RE_W <= DM_RE_M; DM_WE_W <= DM_WE_M;
 DMOOp_W <= DMOOp_M; DMIOp_W <= DMIOp_M; A3sel_W <= A3sel_M; WDsel_W <= WDsel_M; GRF_WE_W <= GRF_WE_M; Tuse_Rs_W <= Tuse_Rs_M;
 Tuse_Rt_W <= Tuse_Rt_M; eret_W <= eret_M; CP0_WE_W <= CP0_WE_M;
	end
end

endmodule


