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
`include "macro.v"

module cp0(
	 input [31:0] IR_M, IR_E, IR_D,
    input [4:0] RA,
    input [4:0] WA,
    input [31:0] DIn,
    output [31:0] DOut,
    input reset, clk,
    input WE,
	input [31:0] PC_M, PC_E, PC_D,
	input Exc,
	input [6:2] ExcCode, 
	input [7:2] HWInt,
	input EXLClr,
	output IntReq,
	output [31:0] EPC,
	input slot_M, slot_E, slot_D, 
	input eret, pause_M, pause_E
    );

reg [31:0] R[12:15];

assign DOut = RA == 12 ? R[`SR] :
			  RA == 13 ? R[`CAUSE] :
			  RA == 14 ? {R[`EPC][31:2], {2'b00}} :
			  RA == 15 ? R[`PrID] :
			  32'b0;

assign EPC = R[`EPC];

wire [31:0] CAUSE = R[`CAUSE];

wire [7:2] IntBit = R[`SR][`IM] & HWInt;
wire Inte = R[`SR][`IE] && !R[`SR][`EXL] && (|IntBit);

wire slot = pause_M ? (pause_E ? slot_D === 1 : slot_E === 1) : slot_M === 1;

always @(posedge clk) begin
	if (reset) begin
		R[`SR] <= 32'h0000_ff11;
		R[`CAUSE] <= 0;
		R[`EPC] <= 0;
		R[`PrID] <= "ZZYC"; 
	end else if (WE) begin
		//if (WA == 12 || WA == 14)
		R[WA] <= DIn;
	end
	
	//if (EXLSet)
	//	R[`SR][`EXL] <= 1;
	if (EXLClr)
		R[`SR][`EXL] <= 0;
	
	
	// Interruption
	if (Inte) begin
		R[`CAUSE][`IP] <= HWInt;
		if (slot) begin
			R[`EPC] <= pause_M ? (pause_E ? PC_D-4 : PC_E-4) : PC_M - 4;
			R[`CAUSE][`BD] <= 1;
		end else begin
			R[`EPC] <= pause_M ? (pause_E ? PC_D : PC_E) : PC_M;
		end
		R[`SR][`EXL] <= 1;
		R[`CAUSE][`ExcCode] <= `Int;
		R[`CAUSE][9:8] <= 0;
	end else
	
	// Exception
	if (Exc) begin
		R[`CAUSE][`IP] <= HWInt;
		if (slot) begin
			R[`EPC] <= pause_M ? (pause_E ? PC_D-4 : PC_E-4) : PC_M - 4;
			R[`CAUSE][`BD] <= 1;
		end else begin
			R[`EPC] <= pause_M ? (pause_E ? PC_D : PC_E) : PC_M;
		end
		R[`CAUSE][`ExcCode] <= ExcCode;
		R[`CAUSE][9:8] <= 0;
		R[`SR][`EXL] <= 1;
	end
	
	if (eret) begin
		//R[`SR][`EXL] <= 0; 
		R[`CAUSE][`BD] <= 0;
	end
	
end

//assign IntReq = Exc || Inte;
assign IntReq = Inte;

wire EXL = R[`SR][`EXL];

endmodule
