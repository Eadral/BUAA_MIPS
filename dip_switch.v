`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:10:18 12/22/2018 
// Design Name: 
// Module Name:    dip_switch 
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
module dip_switch(
    input [7:0] dip_switch0, dip_switch1, dip_switch2, dip_switch3, 
	 input [7:0] dip_switch4, dip_switch5, dip_switch6, dip_switch7, 
	 
	 input [31:0] ADD_I,
	 output [31:0] DAT_O,
	 
	 output IRQ_O,
	 input clk, reset
    );

wire [31:0] v1 = {~dip_switch3, ~dip_switch2, ~dip_switch1, ~dip_switch0};
wire [31:0] v0 = {~dip_switch7, ~dip_switch6, ~dip_switch5, ~dip_switch4};

assign DAT_O = ADD_I == 32'h0000_7f2c ? v0:
				   ADD_I == 32'h0000_7f30 ? v1:
				   32'b0;

reg [31:0] state0, state1;
always @(posedge clk) begin
	if (reset) begin
		state0 <= v0;
		state1 <= v1;
	end else begin
		state0 <= v0;
		state1 <= v1;
	end
end

assign IRQ_O = !reset & (state0 != v0 || state1 != v1 ? 1 : 0);

endmodule
