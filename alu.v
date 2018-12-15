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
	 output Overflow
    );

reg t32;
assign Overflow = t32 ^ Out[31];

always @(*)
case (Op)
	4'b0000: {t32, Out} = {A[31], A} + {B[31], B};
	4'b0001: {t32, Out} = {A[31], A} - {B[31], B};
	4'b0010: Out = A & B;
	4'b0011: Out = A | B;
	4'b0100: Out = B >> A[4:0];
	4'b0101: Out = $signed(B) >>> A[4:0];
	4'b0110: Out = B << A[4:0];
	4'b0111: Out = $signed($signed(A) < $signed(B)) ? 1 : 0;
	4'b1000: Out = A < B ? 1 : 0;
	4'b1001: Out = ~(A | B);
	4'b1010: Out = A ^ B;
	4'b1011: Out = A;
	4'b1100: Out = B;
	4'b1101: Out = (B << 32 - A[4:0])| (B >> A[4:0]);
	
	default: Out = 32'bx;
endcase

endmodule
