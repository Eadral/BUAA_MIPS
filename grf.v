`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:43 11/15/2018 
// Design Name: 
// Module Name:    GRF 
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
module grf(
    input [4:0] RA1,
    input [4:0] RA2,
    input [4:0] WA,
    input [31:0] WD,
    output [31:0] RD1,
    output [31:0] RD2,
    input Reset,
    input clk,
    input WE,
	 input [31:0] PC
    );

reg [31:0] R[0:31];

assign RD1 = R[RA1];
assign RD2 = R[RA2];

integer i;


always @(posedge clk) begin
	if (Reset) begin
		for (i = 0; i < 32; i = i + 1)
			R[i] <= 0;
	end else if (WE && WA != 5'b00000) begin
		$display("%d@%h: $%d <= %h", $time, PC, WA, WD);
		R[WA] <= WD;
	end
end



endmodule
