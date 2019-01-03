`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:50 12/05/2018 
// Design Name: 
// Module Name:    timer 
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

`define Mode 2:1
`define Enable 0

module timer(
    input [3:0] ADD_I,
	 input WE_I,
    input [31:0] DAT_I,
    output reg [31:0] DAT_O,
	 output IRQ_O,  
	 input clk, reset
    );

reg [31:0] CTRL, PRESET, COUNT;

wire IM = CTRL[3];
wire [1:0] Mode = CTRL[`Mode];
wire Enable = CTRL[`Enable];

reg [5:0] state;

parameter IDLE = 0,
			 LOAD = 1,
			 CNTING = 2,
			 INT = 3;

reg IRQ;

assign IRQ_O = IM ? IRQ : 0;

always @(posedge clk) begin
	if (WE_I && reset == 0) begin
		case (ADD_I)
			4'd0: CTRL <= DAT_I;     
			4'd4: PRESET <= DAT_I; 
			//4'd8: COUNT <= DAT_I; 
		endcase
	end else
	if (reset) begin
		CTRL <= 0;
		PRESET <= 0;
		COUNT <= 0;
		
		state <= IDLE;
		IRQ <= 0;
	end else begin
	case (state)
		IDLE: begin
			if (Enable) begin
				state <= LOAD;
				IRQ <= 0;
			end
		end
		LOAD: begin
			COUNT <= PRESET;
			state <= CNTING;
		end
		CNTING: begin
			if (!Enable) 
				state <= IDLE;
			else begin
				if (COUNT > 1) begin
					COUNT <= COUNT - 1;
				end else if (COUNT == 1 && Enable) begin
					COUNT <= COUNT - 1;
					state <= INT;
					IRQ <= 1;
				end
			end
		end
		INT: begin
			if (Mode == 0) begin
				CTRL[`Enable] <= 0;
				//IRQ <= 0;
				state <= IDLE;
			end else begin
				IRQ <= 0;
				state <= IDLE;
			end
		end
	endcase
	
	end
end

always @(*) begin
		 DAT_O = ADD_I == 4'b0000 ? CTRL :
					ADD_I == 4'b0100 ? PRESET :
					ADD_I == 4'b1000 ? COUNT :
					32'bx;
end

endmodule
