`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:00 11/22/2018 
// Design Name: 
// Module Name:    mips 
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
 /**/

module mips(
    input clk_in,
    input sys_rstn,
	 
	 input uart_rxd,
	 output uart_txd,
	 
	 input [7:0] dip_switch0, dip_switch1, dip_switch2, dip_switch3, 
	 input [7:0] dip_switch4, dip_switch5, dip_switch6, dip_switch7, 
	 
	 input [7:0] user_key,
	 
	 output [31:0] led_light,
	 
	 output [7:0] digital_tube2, digital_tube1, digital_tube0,
	 output digital_tube_sel2,
	 output [3:0] digital_tube_sel1, digital_tube_sel0
    );

clock Clock
(// Clock in ports
 .CLK_IN1(clk_in),      // IN
 // Clock out ports
 .CLK_OUT1(clk),     // OUT
 .CLK_OUT2(clk2));    // OUT

wire [31:0] PrAddr, PrRD, PrWD, DEV_Addr, DEV_WD;
wire [31:0] DEV1_RD, DEV2_RD, DEV3_RD, DEV4_RD, DEV5_RD, DEV6_RD;
wire PrWE;
wire [7:2] HWInt;
wire reset = ~sys_rstn;

wire [7:2] Int = reset ? 6'b0 : HWInt;

cpu CPU(
    .clk(clk), .clk2(clk2),
    .reset(reset), 
    .PrAddr(PrAddr), 
    .PrWD(PrWD), 
    .PrRD(PrRD), 
    .PrWE(PrWE), 
    .HWInt(Int)
    );
	 
bridge Bridge(
    .PrAddr(PrAddr), 
    .PrWD(PrWD), .PrRD(PrRD), .PrWE(PrWE),
    .DEV_Addr(DEV_Addr), .DEV_WD(DEV_WD), 
    .DEV1_RD(DEV1_RD), .DEV2_RD(DEV2_RD), .DEV3_RD(DEV3_RD), .DEV4_RD(DEV4_RD), .DEV5_RD(DEV5_RD), .DEV6_RD(DEV6_RD),
	 .DEV1_WE(DEV1_WE), .DEV2_WE(DEV2_WE), .DEV3_WE(DEV3_WE), .DEV4_WE(DEV4_WE), .DEV5_WE(DEV5_WE), .DEV6_WE(DEV6_WE),
	 .DEV2_STB(DEV2_STB)
    );



timer Timer0(
    .ADD_I(DEV_Addr[3:0]), 
    .WE_I(DEV1_WE), .DAT_I(DEV_WD), .DAT_O(DEV1_RD), 
    .IRQ_O(HWInt[2]), .clk(clk), .reset(reset)
    );

wire [31:0] uart_add = DEV_Addr - 32'h0000_7f10;
MiniUART miniUART (
    .ADD_I(uart_add[4:2]), 
    .DAT_I(DEV_WD), 
    .DAT_O(DEV2_RD), 
    .STB_I(DEV2_STB), 
    .WE_I(DEV2_WE), 
    .CLK_I(clk), 
    .RST_I(reset), 
    .IRQ_O(HWInt[3]), 
    .RxD(uart_rxd), 
    .TxD(uart_txd)
    );
	 
dip_switch Dip_Switch (
    .dip_switch0(dip_switch0), .dip_switch1(dip_switch1), .dip_switch2(dip_switch2), .dip_switch3(dip_switch3), 
    .dip_switch4(dip_switch4), .dip_switch5(dip_switch5), .dip_switch6(dip_switch6), .dip_switch7(dip_switch7), 
    .ADD_I(DEV_Addr), .DAT_O(DEV3_RD), .IRQ_O(HWInt[4]),
	 .clk(clk), .reset(reset)
    );

led_light Led_Light (
    .led_light(led_light), 
    .ADD_I(DEV_Addr), .WE_I(DEV4_WE), .DAT_I(DEV_WD), .DAT_O(DEV4_RD), 
    .clk(clk), .reset(reset)
    );

digital_tube Digital_Tube (
    .digital_tube2(digital_tube2), .digital_tube1(digital_tube1), .digital_tube0(digital_tube0), 
    .digital_tube_sel2(digital_tube_sel2), .digital_tube_sel1(digital_tube_sel1), .digital_tube_sel0(digital_tube_sel0), 
    .ADD_I(DEV_Addr), .DAT_I(DEV_WD), .WE_I(DEV5_WE), .DAT_O(DEV5_RD), 
    .clk(clk), .reset(reset)
    );

user_key User_Key (
    .user_key(user_key), 
    .ADD_I(DEV_Addr), .DAT_O(DEV6_RD), .IRQ_O(HWInt[5]), 
	 .clk(clk), .reset(reset)
    );

assign HWInt[7:6] = 0;

endmodule
