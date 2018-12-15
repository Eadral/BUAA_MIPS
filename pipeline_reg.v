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

initial begin
	IR_D = 32'b0;
	PC_D = 32'b0;
	PC8_D = 32'b0;
	Exc_D = 0;
	ExcCode_D = 0;
	slot_D = 0;
end

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
	 input reset
    );
	 
initial begin
	IR_E	= 32'b0; 
	PC_E	= 32'b0; 
	PC8_E	= 32'b0; 
	Rs_E	= 32'b0; 
	Rt_E	= 32'b0; 
	Ext_E	= 32'b0; 
	Tnew_E = 0;
	Jump_E = 0;
	Exc_E = 0;
	slot_E = 0;
	ExcCode_E = 0;
	pause_E = 0;
end

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
	end
end

endmodule


//


module E_M_reg(
    input [31:0] IR_E,
    input [31:0] PC_E,
    input [31:0] PC8_E,
    input [31:0] ALUOut_E,
    input [31:0] XALUOut_E,
    input [31:0] Rt_E,
	 input [4:0] A3_E,
	 input [1:0] Tnew_E,
	 input Exc_E, slot_E,
	 input [4:0] ExcCode_E,
	 input Start_E,
	 input pause_E,
	 output reg Exc_M, slot_M,
	 output reg [4:0] ExcCode_M,
	 output reg [31:0] IR_M,
	 output reg [31:0] PC_M,
	 output reg [31:0] PC8_M,
	 output reg [31:0] ALUOut_M,
	 output reg [31:0] XALUOut_M,
	 output reg [31:0] Rt_M,
	 output reg [4:0] A3_M,
	 output reg [1:0] Tnew_M,
	 output reg Start_M,
	 output reg pause_M,
	 input clk,
	 input reset
    );

initial begin
	IR_M	= 32'b0;
	PC_M = 32'b0;
	PC8_M = 32'b0;
	ALUOut_M = 32'b0;
	XALUOut_M = 32'b0;
   Rt_M = 32'b0;
	Tnew_M = 0;
	A3_M = 0;
	Exc_M = 0;
	slot_M = 0;
	ExcCode_M = 0;
	Start_M = 0;
	pause_M = 0;
end

always @(posedge clk) begin
	if (reset) begin
		IR_M	<= 32'b0;
		PC_M <= 32'b0;
		PC8_M <= 32'b0;
		ALUOut_M <= 32'b0;
		XALUOut_M <= 32'b0;
		Rt_M <= 32'b0;
		Tnew_M <= 0;
		A3_M <= 0;
		Exc_M <= 0;
		slot_M <= 0;
		ExcCode_M <= 0;
		Start_M <= 0;
		pause_M <= 0;
	end else begin
		IR_M	<= 		IR_E;
		PC_M <=       PC_E;
		PC8_M <=       PC8_E;
		ALUOut_M <=    ALUOut_E;
		XALUOut_M <=   XALUOut_E;
		Rt_M <=        Rt_E;
		A3_M <=	A3_E;
		Exc_M <= Exc_E;
		slot_M <= slot_E;
		ExcCode_M <= ExcCode_E;
		Start_M <= Start_E;
		pause_M <= pause_E;
		if (Tnew_E > 0)
			Tnew_M <= Tnew_E - 1;
		else 
			Tnew_M <= 0;
	end
end


endmodule


//


module M_W_reg(
    input [31:0] IR_M,
    input [31:0] PC_M,
    input [31:0] PC8_M,
    input [31:0] ALUOut_M,
    input [31:0] XALUOut_M,
    input [31:0] DM_M,
    input [31:0] CP0_M,
	 input [4:0] A3_M,
	 input [1:0] Tnew_M,
	 output reg [31:0] IR_W,
	 output reg [31:0] PC_W,
	 output reg [31:0] PC8_W,
	 output reg [31:0] ALUOut_W,
	 output reg [31:0] XALUOut_W,
	 output reg [31:0] DM_W,
	 output reg [31:0] CP0_W,
	 output reg [4:0] A3_W,
	 output reg [1:0] Tnew_W,
	 input clk,
	 input reset
    );

initial begin
	IR_W		= 32'b0;
   PC_W		= 32'b0;
   PC8_W		= 32'b0;
   ALUOut_W	= 32'b0;
   XALUOut_W= 32'b0;
   DM_W		= 32'b0;
   CP0_W		= 32'b0;
	Tnew_W	= 0;
	A3_W		= 0;
end

always @(posedge clk) begin
	if (reset) begin
		IR_W		<= 32'b0;
		PC_W		<= 32'b0;
		PC8_W		<= 32'b0;
		ALUOut_W	<= 32'b0;
		XALUOut_W<= 32'b0;
		DM_W		<= 32'b0;
		CP0_W		<= 32'b0;
		Tnew_W	<= 0;
		A3_W		<= 0;
	end else begin
		IR_W		<= IR_M;
		PC_W		<= PC_M;
		PC8_W		<= PC8_M;
		ALUOut_W	<= ALUOut_M;
		XALUOut_W<= XALUOut_M;
		DM_W		<= DM_M;
		CP0_W		<= CP0_M;
		A3_W 		<= A3_M;
		if (Tnew_M > 0)
			Tnew_W <= Tnew_M - 1;
		else 
			Tnew_W <= 0;
	end
end

endmodule


