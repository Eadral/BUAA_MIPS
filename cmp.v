`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:01:17 11/23/2018 
// Design Name: 
// Module Name:    cmp 
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
module cmp(
    input [31:0] Rs,
    input [31:0] Rt,
    input [3:0] Op,
    output reg Jump
    );


always @(*) begin
case (Op)
	0: Jump = ($signed(Rs) == $signed(Rt)) ? 1 : 0;
	1: Jump = ($signed(Rs) >= 0) ? 1 : 0;
	2: Jump = ($signed(Rs) > 0) ? 1 : 0;
	3: Jump = ($signed(Rs) <= 0) ? 1 : 0;
	4: Jump = ($signed(Rs) < 0) ? 1 : 0;
	5: Jump = ($signed(Rs) != $signed(Rt)) ? 1 : 0;
	default: Jump = (Rs == Rt) ? 1 : 0;
endcase
end




endmodule
