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
    input [31:0] PC4_F,
    input [31:0] PC8_F,
    output reg [31:0] IR_D,
    output reg [31:0] PC4_D,
    output reg [31:0] PC8_D,
	 input clk,
    input stall,
	 input reset
    );

initial begin
	IR_D = 32'b0;
	PC4_D = 32'b0;
	PC8_D = 32'b0;
end

always @(posedge clk) begin
	if (reset) begin
		IR_D = 32'b0;
		PC4_D = 32'b0;
		PC8_D = 32'b0;
	end else
	if (!stall) begin
		IR_D  <= IR_F ;
		PC4_D <= PC4_F;
		PC8_D <= PC8_F;
	end

end


endmodule


//

module D_E_reg(
    input [31:0] IR_D,
    input [31:0] PC4_D,
    input [31:0] PC8_D,
    input [31:0] Rs_D,
    input [31:0] Rt_D,
    input [31:0] Ext_D,
	 output reg [31:0] IR_E,
	 output reg [31:0] PC4_E,
	 output reg [31:0] PC8_E,
	 output reg [31:0] Rs_E,
	 output reg [31:0] Rt_E,
	 output reg [31:0] Ext_E,
	 input clk,
	 input clr,
	 input reset
    );
	 
initial begin
	IR_E	= 32'b0; 
	PC4_E	= 32'b0; 
	PC8_E	= 32'b0; 
	Rs_E	= 32'b0; 
	Rt_E	= 32'b0; 
	Ext_E	= 32'b0; 
end

always @(posedge clk) begin
	if (reset) begin
		IR_E	= 32'b0; 
		PC4_E	= 32'b0; 
		PC8_E	= 32'b0; 
		Rs_E	= 32'b0; 
		Rt_E	= 32'b0; 
		Ext_E	= 32'b0; 
	end else
	if (clr) begin
		IR_E	<= 32'b0; 
		PC4_E	<= 32'b0; 
		PC8_E	<= 32'b0; 
		Rs_E	<= 32'b0; 
		Rt_E	<= 32'b0; 
		Ext_E	<= 32'b0; 
	end else begin
		IR_E	<= IR_D; 
		PC4_E	<= PC4_D; 
		PC8_E	<= PC8_D; 
		Rs_E	<= Rs_D; 
		Rt_E	<= Rt_D; 
		Ext_E	<= Ext_D; 
	end
end

endmodule


//


module E_M_reg(
    input [31:0] IR_E,
    input [31:0] PC4_E,
    input [31:0] PC8_E,
    input [31:0] ALUOut_E,
    input [31:0] XALUOut_E,
    input [31:0] Rt_E,
	 output reg [31:0] IR_M,
	 output reg [31:0] PC4_M,
	 output reg [31:0] PC8_M,
	 output reg [31:0] ALUOut_M,
	 output reg [31:0] XALUOut_M,
	 output reg [31:0] Rt_M,
	 input clk,
	 input reset
    );

initial begin
	IR_M	= 32'b0;
	PC4_M = 32'b0;
	PC8_M = 32'b0;
	ALUOut_M = 32'b0;
	XALUOut_M = 32'b0;
   Rt_M = 32'b0;
end

always @(posedge clk) begin
	if (reset) begin
		IR_M	= 32'b0;
		PC4_M = 32'b0;
		PC8_M = 32'b0;
		ALUOut_M = 32'b0;
		XALUOut_M = 32'b0;
		Rt_M = 32'b0;
	end else begin
		IR_M	<= 		IR_E;
		PC4_M <=       PC4_E;
		PC8_M <=       PC8_E;
		ALUOut_M <=    ALUOut_E;
		XALUOut_M <=   XALUOut_E;
		Rt_M <=        Rt_E;
	end
end


endmodule


//


module M_W_reg(
    input [31:0] IR_M,
    input [31:0] PC4_M,
    input [31:0] PC8_M,
    input [31:0] ALUOut_M,
    input [31:0] XALUOut_M,
    input [31:0] DM_M,
	 output reg [31:0] IR_W,
	 output reg [31:0] PC4_W,
	 output reg [31:0] PC8_W,
	 output reg [31:0] ALUOut_W,
	 output reg [31:0] XALUOut_W,
	 output reg [31:0] DM_W,
	 input clk,
	 input reset
    );

initial begin
	IR_W		= 32'b0;
   PC4_W		= 32'b0;
   PC8_W		= 32'b0;
   ALUOut_W	= 32'b0;
   XALUOut_W= 32'b0;
   DM_W		= 32'b0;
end

always @(posedge clk) begin
	if (reset) begin
		IR_W		= 32'b0;
		PC4_W		= 32'b0;
		PC8_W		= 32'b0;
		ALUOut_W	= 32'b0;
		XALUOut_W= 32'b0;
		DM_W		= 32'b0;
	end else begin
		IR_W		<= IR_M;
		PC4_W		<= PC4_M;
		PC8_W		<= PC8_M;
		ALUOut_W	<= ALUOut_M;
		XALUOut_W<= XALUOut_M;
		DM_W		<= DM_M;
	end
end

endmodule


