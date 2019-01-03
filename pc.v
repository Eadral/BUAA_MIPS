`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:04:18 11/15/2018 
// Design Name: 
// Module Name:    IFU 
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
module pc(
    input [31:0] NPC,
    output reg [31:0] PC,
    input clk,
	 input stall,
    input Reset
    );

always @(posedge clk) begin
	if (Reset)
		PC <= 32'h0000_3000;
	else if (!stall)
		PC <= NPC;
end

endmodule
