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
`include "macro.v"

module forward(
	 
	 input [31:0] IR_D,
	 input [31:0] IR_E,
	 input [31:0] IR_M,
	 input [31:0] IR_W,
	 
	 input RWE_E,
	 input RWE_M,
	 input RWE_W,
	 input [4:0] A3_E, A3_M, A3_W,
	 
	 output reg [1:0] ForwardRS_D,
	 output reg [1:0] ForwardRT_D,
	 
	 output reg [1:0] ForwardRS_E,
	 output reg [1:0] ForwardRT_E,
	 
	 output reg [1:0] ForwardRT_M,
	 
	 output reg Forward_RD1,
	 output reg Forward_RD2,
	 
	 input CP0_WE_E, CP0_WE_M,
	 output reg [1:0] Forward_EPC
    );
	 

always @(*) begin
	
	// Forward_EPC
	if (IR_D == `eret && CP0_WE_E && IR_E[`Rd] == 14)
		Forward_EPC = 1;
	else if (IR_D == `eret && CP0_WE_M && IR_M[`Rd] == 14) 
		Forward_EPC = 2;
	else
		Forward_EPC = 0;
	
	
	// Forward_RD1
	if ((IR_D[`Rs] == A3_W) && (A3_W != 0) && RWE_W)  
		Forward_RD1 = 1;
	else 
		Forward_RD1 = 0;
		
	// Forward_RD2
	if ((IR_D[`Rt] == A3_W) && (A3_W != 0) && RWE_W)  
		Forward_RD2 = 1;
	else 
		Forward_RD2 = 0;
	
	// ForwardRS_D
	if ((A3_M != 0) && (IR_D[`Rs] == A3_M) && RWE_M) begin
		ForwardRS_D = 1;
	end else if ((A3_W != 0) && (IR_D[`Rs] == A3_W) && RWE_W) begin
		ForwardRS_D = 2;
	end else if ((A3_E != 0) && (IR_D[`Rs] == A3_E) && RWE_E) begin
		ForwardRS_D = 3;
	end else begin
		ForwardRS_D = 0;
	end
	
	
	// ForwardRT_D
	if ((A3_M != 0) && (IR_D[`Rt] == A3_M) && RWE_M) begin
		ForwardRT_D = 1;
	end else if ((A3_W != 0) && (IR_D[`Rt] == A3_W) && RWE_W) begin
		ForwardRT_D = 2;
	end else if ((A3_E != 0) && (IR_D[`Rt] == A3_E) && RWE_E) begin
		ForwardRT_D = 3;
	end else begin
		ForwardRT_D = 0;
	end
	
	//
	
	// ForwardRS_E
	if ((A3_M != 0) && (IR_E[`Rs] == A3_M) && RWE_M) begin
		ForwardRS_E = 1;
	end else if ((A3_W != 0) && (IR_E[`Rs] == A3_W) && RWE_W) begin
		ForwardRS_E = 2;
	end else begin
		ForwardRS_E = 0;
	end
	
	// ForwardRT_E
	if ((A3_M != 0) && (IR_E[`Rt] == A3_M) && RWE_M) begin
		ForwardRT_E = 1;
	end else if ((A3_W != 0) && (IR_E[`Rt] == A3_W) && RWE_W) begin
		ForwardRT_E = 2;
	end else begin
		ForwardRT_E = 0;
	end
	
	//
	
	// ForwardRT_M
	if ((A3_W != 0) && (IR_M[`Rt] == A3_W) && RWE_W) begin
		ForwardRT_M = 1;
	end else begin
		ForwardRT_M = 0;
	end
	
	
	
end


endmodule
