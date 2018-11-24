`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:38:01 11/16/2018 
// Design Name: 
// Module Name:    JExt 
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
module npc(
    input [31:0] PC4,
    input [25:0] Add,
	 input npcOp,
    output reg [31:0] NPC
    );

always @(*) begin
case (npcOp)
	0: NPC = PC4 + ({{16{Add[15]}}, Add[15:0]} << 2);
	1: NPC = {PC4[31:28], Add, 2'b00};
endcase
end

endmodule
