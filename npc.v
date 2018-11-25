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
    input [31:0] PC,
    input [25:0] Add,
	 input [1:0] npcOp,
	 input Jump,
    output reg [31:0] NPC
    );

always @(*) begin
case (npcOp)
	0: begin
		if (Jump)
			NPC = PC + 4 + ({{16{Add[15]}}, Add[15:0]} << 2);
		else
			NPC = PC + 8;
	end
	1: NPC = {PC[31:28], Add, 2'b00};
endcase
end

endmodule
