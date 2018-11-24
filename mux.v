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
    input [31:0] d0, d1,
	 input s,
	 output [31:0] out
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