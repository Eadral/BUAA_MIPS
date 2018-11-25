`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:55:00 11/15/2018 
// Design Name: 
// Module Name:    DM 
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
module dm(
    input [31:0] A,
    input [31:0] WD,
    output [31:0] RD,
    input RE,
    input WE,
    input clk,
    input Reset,
	 input [31:0] PC
    );

reg [31:0] dm [0:1023];

integer i;
initial 
	for (i = 0; i < 1024; i = i + 1)
		dm[i] = 0;

always @(posedge clk) begin
	if (Reset) begin
		for (i = 0; i < 1024; i = i + 1)
			dm[i] <= 0;
	end if (WE) begin
		$display("%d@%h: *%h <= %h", $time, PC, A, WD);
		dm[A[11:2]] <= WD;
	end
end

assign RD = RE ? dm[A[11:2]] : 32'bx;

endmodule
