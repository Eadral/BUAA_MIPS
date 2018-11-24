`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:47 11/15/2018 
// Design Name: 
// Module Name:    Ext 
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
module ext(
    input [15:0] In,
    output reg [31:0] Out,
    input [1:0] Op
    );

always @(*)
case (Op)
	2'b00: begin
		Out = {{16{In[15]}}, In};
	end
	2'b01: begin
		Out = {{16{1'b0}}, In};
	end
	2'b10: begin
		Out = {In, {16{1'b0}}};
	end
	2'b11: begin
		Out = {{16{In[15]}}, In} << 2;
	end
endcase

endmodule
