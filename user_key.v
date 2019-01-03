`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:11 12/22/2018 
// Design Name: 
// Module Name:    user_key 
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
module user_key(
    input [7:0] user_key,
	 
	 input [31:0] ADD_I,
	 output [31:0] DAT_O,
	 
	 output IRQ_O,
	 input clk, reset
    );

reg [7:0] state;
wire [7:0] key = ~user_key;

always @(posedge clk) begin
	if (reset) begin
		state <= key;
	end else begin
		state <= key;
	end
end

assign DAT_O = ADD_I == 32'h0000_7f40 ? key : 32'b0;

assign IRQ_O = !reset & (state != key ? 1 : 0);

endmodule
