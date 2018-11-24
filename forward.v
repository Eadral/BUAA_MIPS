`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:12:20 11/24/2018 
// Design Name: 
// Module Name:    forward 
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
`define Op 31:26
`define Rs 25:21
`define Rt 20:16
`define Rd 15:11
`define Shamt 10:6
`define Func 5:0

`define Imm 15:0
`define Addr 25:0

module forward(
	 
	 input [31:0] IR_D,
	 input [31:0] IR_E,
	 input [31:0] IR_M,
	 
	 input RWE_M,
	 input [1:0] A3sel_M,
	 
	 input RWE_W,
	 input [1:0] A3sel_W,
	 
	 
	 output reg [1:0] ForwardRS_D,
	 output reg [1:0] ForwardRT_D,
	 
	 output reg [1:0] ForwardRS_E,
	 output reg [1:0] ForwardRT_E,
	 
	 output reg [1:0] ForwardRT_M
    );

initial begin
	ForwardRS_D = 0;
	ForwardRT_D = 0;

	ForwardRT_E = 0;
	ForwardRS_E = 0;

	ForwardRT_M = 0;
end

always @(*) begin
	// ForwardRS_D
	if ((IR_D[`Rs] == A3sel_M) && RWE_M) begin
		ForwardRS_D = 1;
	end else if ((IR_D[`Rs] == A3sel_W) && RWE_W) begin
		ForwardRS_D = 2;
	end else begin
		ForwardRS_E = 0;
	end
	
	
	// ForwardRT_D
	if ((IR_D[`Rt] == A3sel_M) && RWE_M) begin
		ForwardRS_D = 1;
	end else if ((IR_D[`Rt] == A3sel_W) && RWE_W) begin
		ForwardRS_D = 2;
	end else begin
		ForwardRS_E = 0;
	end
	
	//
	
	// ForwardRS_E
	if ((IR_E[`Rs] == A3sel_M) && RWE_M) begin
		ForwardRS_E = 1;
	end else if ((IR_E[`Rs] == A3sel_W) && RWE_W) begin
		ForwardRS_E = 2;
	end else begin
		ForwardRS_E = 0;
	end
	
	// ForwardRT_E
	if ((IR_E[`Rt] == A3sel_M) && RWE_M) begin
		ForwardRT_E = 1;
	end else if ((IR_E[`Rt] == A3sel_W) && RWE_W) begin
		ForwardRT_E = 2;
	end else begin
		ForwardRT_E = 0;
	end
	
	//
	
	// ForwardRT_M
	if ((IR_M[`Rt] == A3sel_W) && RWE_W) begin
		ForwardRT_E = 1;
	end else begin
		ForwardRT_E = 0;
	end
	
end


endmodule
