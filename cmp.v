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
    input [31:0] A,
    input [31:0] B,
    input [1:0] Op,
    output Zero
    );

/*
always @(*) begin
case (Op)
	2'b00: Zero = (A == B) ? 1 : 0;
	default: Zero = (A == B) ? 1 : 0;
endcase
end
*/

assign Zero = (A == B) ? 1 : 0;

endmodule