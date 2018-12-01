`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:26:14 11/15/2018 
// Design Name: 
// Module Name:    mux 
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

module mux2 #(parameter WIDTH=32) (
    input [WIDTH-1:0] d0, d1,
	 input s,
	 output [WIDTH-1:0] out
    );

assign out = s ? d1 : d0;

endmodule



module mux4 #(parameter WIDTH=32) (
    input [WIDTH-1:0] d0, d1, d2, d3,
	 input [1:0] s,
	 output reg [WIDTH-1:0] out
	 );
	 
always @(*)
case (s)
	2'b00: out = d0;
	2'b01: out = d1;
	2'b10: out = d2;
	2'b11: out = d3;
endcase
	
endmodule 


module mux8 #(parameter WIDTH=32) (
    input [WIDTH-1:0] d0, d1, d2, d3, d4, d5, d6, d7,
	 input [2:0] s,
	 output reg [WIDTH-1:0] out
	 );
	 
always @(*)
case (s)
	3'b000: out = d0;
	3'b001: out = d1;
	3'b010: out = d2;
	3'b011: out = d3;
	3'b100: out = d4;
	3'b101: out = d5;
	3'b110: out = d6;
	3'b111: out = d7;
endcase
	
endmodule 