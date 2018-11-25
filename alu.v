`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:48 11/15/2018 
// Design Name: 
// Module Name:    ALU 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [3:0] Op,
    output reg [31:0] Out,
	 output Zero
    );

assign Zero = Out == 0 ? 1 : 0;

always @(*)
case (Op)
	4'b0000: Out = A + B;
	4'b0001: Out = A - B;
	4'b0010: Out = A & B;
	4'b0011: Out = A | B;
	4'b0100: Out = A >> B;
	4'b0101: Out = $signed(A) >>> B;
	4'b0110: Out = A << B;
	4'b0111: Out = $signed(A) < $signed(B) ? 1 : 0;
	4'b1000: Out = A < B;
	
	default: Out = 32'bx;
endcase

endmodule