`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:16:38 11/29/2018 
// Design Name: 
// Module Name:    MDU 
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
module xalu(
	 input [31:0] D1, D2,
	 input [3:0] XALUOp,
	 input Start,
	 output [31:0] XALU_Out,
	 output Busy,
	 input clk, reset
    );
	
reg [31:0] cycle;	
reg [31:0] HI, LO;
reg [31:0] mHI, mLO;

assign Busy = cycle == 0 ? 0 : 1;

initial begin
	cycle = 0;
	HI = 0;
	LO = 0;
end

assign XALU_Out = XALUOp == 5 ? HI :
						XALUOp == 6 ? LO :
						32'bx;

always @(posedge clk) begin
	if (reset) begin
		cycle <= 0;
		HI <= 0;
		LO <= 0;
	end else begin
		if (cycle == 0 && Start) begin
			case (XALUOp) 
				1: begin: mult
					{HI, LO} <= $signed(D1) * $signed(D2);
					cycle <= 5;
				end
				2: begin: multu
					{HI, LO} <= D1 * D2;
					cycle <= 5;
				end
				3: HI <= D1;
				4: LO <= D1;
				//5: XALU_Out <= HI;
				//6: XALU_Out <= LO;
				7: begin: div
					if (D2 == 0) begin
						LO <= LO;
						HI <= HI;
					end else begin
						LO <= $signed(D1) / $signed(D2);
						HI <= $signed(D1) % $signed(D2);
						cycle <= 10;
					end
				end
				8: begin: divu
					if (D2 == 0) begin
						LO <= LO;
						HI <= HI;
					end else begin
						LO <= D1 / D2;
						HI <= D1 % D2;
						cycle <= 10;
					end
				end
				9: begin: madd
					{HI, LO} <= $signed({HI, LO}) + $signed(D1) * $signed(D2);
					cycle <= 5;
				end
				10: begin: maddu
					{HI, LO} <= {HI, LO} + D1 * D2;
					cycle <= 5;
				end
				default: {HI, LO} <= {HI, LO};
			endcase
		end else if (cycle > 0) begin
			cycle <= cycle - 1;
		end
	end
end



endmodule
