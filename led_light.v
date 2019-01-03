`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:22:27 12/22/2018 
// Design Name: 
// Module Name:    led_light 
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
module led_light(
    output reg [31:0] led_light,
	 input [31:0] ADD_I,
	 input WE_I,
	 input [31:0] DAT_I,
	 output [31:0] DAT_O,
	 input clk, reset
    );

always @(posedge clk) begin
	if (reset) begin
		led_light = 0;
	end else if (WE_I) begin
		if (ADD_I == 32'h0000_7f34) begin
			$display("LED: %b", DAT_I);
			led_light = ~DAT_I;
		end
	end
	
end

assign DAT_O = ADD_I == 32'h0000_7f34 ? ~led_light : 32'b0;

endmodule
