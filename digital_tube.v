`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:41:03 12/22/2018 
// Design Name: 
// Module Name:    digital_tube 
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
module digital_tube(
    output reg [7:0] digital_tube2, digital_tube1, digital_tube0,
	 output digital_tube_sel2,
	 output reg [3:0] digital_tube_sel1, digital_tube_sel0,
	 
	 input [31:0] ADD_I,
	 input [31:0] DAT_I,
	 input WE_I,
	 output [31:0] DAT_O,
	 input clk, reset
    );

reg [31:0] reg0, reg1;

function [6:0] num2dig;
input [3:0] num;
begin
	case (num)
		4'h0: num2dig = 7'b0000001;
		4'h1: num2dig = 7'b1001111;
		4'h2: num2dig = 7'b0010010;
		4'h3: num2dig = 7'b0000110;
		4'h4: num2dig = 7'b1001100;
		4'h5: num2dig = 7'b0100100;
		4'h6: num2dig = 7'b0100000;
		4'h7: num2dig = 7'b0001111;
		4'h8: num2dig = 7'b0000000;
		4'h9: num2dig = 7'b0000100;
		4'ha: num2dig = 7'b0001000;
		4'hb: num2dig = 7'b1100000;
		4'hc: num2dig = 7'b1110010;
		4'hd: num2dig = 7'b1000010;
		4'he: num2dig = 7'b0110000;
		4'hf: num2dig = 7'b0111000;
		default: num2dig = 7'b0;
	endcase
end
endfunction

always @(*) begin
	case (digital_tube_sel0)
		4'b0001: digital_tube0 = {~reg1[8], num2dig(reg0[3:0])   };
		4'b0010: digital_tube0 = {~reg1[9], num2dig(reg0[7:4])   };
		4'b0100: digital_tube0 = {~reg1[10], num2dig(reg0[11:8])  };
		4'b1000: digital_tube0 = {~reg1[11], num2dig(reg0[15:12]) };
		default: digital_tube0 = 8'b0;    
	endcase                              
	case (digital_tube_sel1)             
		4'b0001: digital_tube1 = {~reg1[12], num2dig(reg0[19:16]) };
		4'b0010: digital_tube1 = {~reg1[13], num2dig(reg0[23:20]) };
		4'b0100: digital_tube1 = {~reg1[14], num2dig(reg0[27:24]) };
		4'b1000: digital_tube1 = {~reg1[15], num2dig(reg0[31:28]) };
		default: digital_tube1 = 8'b0;
	endcase
	if (digital_tube_sel2)
		digital_tube2 = {~reg1[7], ~reg1[6:0]};
		// DP A b C D E F G
end

assign digital_tube_sel2 = 1;
reg [31:0] count;
always @(posedge clk) begin
	if (reset) begin
		count <= 1000;
		digital_tube_sel0 <= 4'b0010;
		digital_tube_sel1 <= 4'b0010; 
	end else begin
		if (count > 1) begin
			count <= count - 1;
		end else begin
			case (digital_tube_sel0)
				4'b0001: digital_tube_sel0 <= 4'b0010;
			   4'b0010: digital_tube_sel0 <= 4'b0100;
			   4'b0100: digital_tube_sel0 <= 4'b1000;
			   4'b1000: digital_tube_sel0 <= 4'b0001;
			   default: digital_tube_sel0 <= 4'b0001;
			endcase
			
			case (digital_tube_sel1)
				4'b0001: digital_tube_sel1 <= 4'b0010;
			   4'b0010: digital_tube_sel1 <= 4'b0100;
			   4'b0100: digital_tube_sel1 <= 4'b1000;
			   4'b1000: digital_tube_sel1 <= 4'b0001;
			   default: digital_tube_sel1 <= 4'b0001;
			endcase
			
			count <= 1000;
		end
	end
end

always @(posedge clk) begin
	if (reset) begin
		reg0 <= 0;
		reg1 <= 0;
	end else if (WE_I) begin
		if (ADD_I == 32'h0000_7f38) 
			reg0 <= DAT_I;
		if (ADD_I == 32'h0000_7f3c) 
			reg1 <= DAT_I;
	end
end

assign DAT_O = ADD_I == 32'h0000_7f38 ? reg0 :
					ADD_I == 32'h0000_7f3c ? reg1 :
					0;

endmodule
