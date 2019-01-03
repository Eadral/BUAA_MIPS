`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:53:29 12/22/2018
// Design Name:   mips
// Module Name:   C:/Users/Eadral/ISE/P8/mips_tb.v
// Project Name:  P8
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mips_tb;

	// Inputs
	reg clk_in;
	reg sys_rstn;
	reg uart_rxd;
	wire uart_txd;
	reg [7:0] dip_switch0;
	reg [7:0] dip_switch1;
	reg [7:0] dip_switch2;
	reg [7:0] dip_switch3;
	reg [7:0] dip_switch4;
	reg [7:0] dip_switch5;
	reg [7:0] dip_switch6;
	reg [7:0] dip_switch7;
	reg [7:0] user_key;

	// Outputs
	wire [31:0] led_light;
	wire [7:0] digital_tube2;
	wire [7:0] digital_tube1;
	wire [7:0] digital_tube0;
	wire digital_tube_sel2;
	wire [3:0] digital_tube_sel1;
	wire [3:0] digital_tube_sel0;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk_in(clk_in), 
		.sys_rstn(sys_rstn), 
		.uart_rxd(uart_rxd), 
		.uart_txd(uart_txd), 
		.dip_switch0(dip_switch0), 
		.dip_switch1(dip_switch1), 
		.dip_switch2(dip_switch2), 
		.dip_switch3(dip_switch3), 
		.dip_switch4(dip_switch4), 
		.dip_switch5(dip_switch5), 
		.dip_switch6(dip_switch6), 
		.dip_switch7(dip_switch7), 
		.user_key(user_key), 
		.led_light(led_light), 
		.digital_tube2(digital_tube2), 
		.digital_tube1(digital_tube1), 
		.digital_tube0(digital_tube0), 
		.digital_tube_sel2(digital_tube_sel2), 
		.digital_tube_sel1(digital_tube_sel1), 
		.digital_tube_sel0(digital_tube_sel0)
	);
	
	//wire [7:0] Buttons = ~user_key;
	//wire [31:0] SwitchA = {~dip_switch_7, ~dip_switch_6, ~dip_switch_5, ~dip_switch_4};
	//wire [31:0] SwitchA = {~dip_switch_3, ~dip_switch_2, ~dip_switch_1, ~dip_switch_0};
	
	`define Buttons user_key
	`define SwitchA {dip_switch7, dip_switch6, dip_switch5, dip_switch4}
	`define SwitchB {dip_switch3, dip_switch2, dip_switch1, dip_switch0}
	initial begin
		// Initialize Inputs
		clk_in = 0;
		sys_rstn = 0;
		uart_rxd = 1;
		dip_switch0 = ~8'h00;
		dip_switch1 = ~8'h00;
		dip_switch2 = ~8'h00;
		dip_switch3 = ~8'h00;
		dip_switch4 = ~8'h00;
		dip_switch5 = ~8'h00;
		dip_switch6 = ~8'h00;
		dip_switch7 = ~8'h00;
		user_key = ~8'h00;
		
		#50 sys_rstn = 0;
		// Wait 100 ns for global reset to finish
		#1005;
      sys_rstn = 1;
		// Add stimulus here
		
		
		
		#15000;
		dip_switch4 = ~8'd3;
		dip_switch0 = ~8'd12;
		user_key = ~8'b0000_0000;
		#100000;
		user_key = ~8'b0000_0001;
		#100000;
		user_key = ~8'b0000_0010;
		#100000;
		user_key = ~8'b0000_0100;
		#100000;
		user_key = ~8'b0000_1000;
		#100000;
		user_key = ~8'b0001_0000;
		#100000;
		user_key = ~8'b0010_0000;
		#100000;
		user_key = ~8'b0100_0000;
		#100000;
		user_key = ~8'b1000_0000;
		#100000;
		
		
		
	end
      
	always #50 clk_in = ~clk_in;
      
endmodule

