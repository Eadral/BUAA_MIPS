`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:44:14 11/23/2018 
// Design Name: 
// Module Name:    stage 
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


module stageF(
	 
	 input [31:0] PC,
	 
    output [31:0] IR_F,
    output [31:0] PC4_F,
    output [31:0] PC8_F,
	 
	 input clk,
	 input reset
	 
	 
    );

im IM(.PC(PC), .Instr(IR_F));
adder ADD4(.A(PC), .B(32'd4), .Out(PC4_F));
adder ADD8(.A(PC4_F), .B(32'd4), .Out(PC8_F));

endmodule


//


module stageD(
	 
	 input [4:0] GRF_A1,
	 input [4:0] GRF_A2,
	 output [31:0] GRF_RD1,
	 output [31:0] GRF_RD2,
	 
	 input [31:0] CMP_D1,
	 input [31:0] CMP_D2,
	 input [3:0] CMPOp,

	 input [15:0] Ext_In,
	 output [31:0] Ext_Out,
	 input [1:0] ExtOp,
	 
	 input [31:0] NPC_PC,
	 input [25:0] NPC_Addr,
	 input [1:0] npcOp,
	 output [31:0] NPCOut,
	 
	 input clk,
	 input reset,
	 
	 output Jump,
	 
	 input [4:0] GRF_A3,
	 input [31:0] GRF_WD,
	 input GRF_WE,
	 
	 input [31:0] PC
    );
	 
	 
grf GRF(.RA1(GRF_A1), .RA2(GRF_A2), .WA(GRF_A3), .WD(GRF_WD), .RD1(GRF_RD1), .RD2(GRF_RD2), .Reset(reset), .clk(clk), .WE(GRF_WE), .PC(PC));

cmp CMP(.Rs(CMP_D1), .Rt(CMP_D2), .Op(CMPOp), .Jump(Jump));

ext Ext(.In(Ext_In), .Out(Ext_Out), .Op(ExtOp));

npc NPC(.PC(NPC_PC), .Add(NPC_Addr), .npcOp(npcOp), .Jump(Jump), .NPC(NPCOut));

endmodule

//


module stageE(
	 
	 input [31:0] ALUa,
	 input [31:0] ALUb,
	 input [3:0] ALUop,
	 output [31:0] ALU_Out,
	 output Overflow,
	 
	 input [31:0] XALUa, XALUb,
	 input [3:0] XALUOp,
	 input Start,
	 output [31:0] XALU_Out,
	 output Busy,
	 input rollback,
	 input clk, reset
	
    );


alu ALU(.A(ALUa), .B(ALUb), .Op(ALUop), .Out(ALU_Out), .Overflow(Overflow));

xalu XALU(.D1(XALUa), .D2(XALUb), .XALUOp(XALUOp), .Start(Start), 
		.XALU_Out(XALU_Out), .Busy(Busy), .clk(clk), .reset(reset),
		.rollback(rollback));

endmodule

//


module stageM(
	 
	 
	 input [31:0] DM_A,
	 input [31:0] DM_WD,
	 output [31:0] DM_Out,
	 input DM_RE,
	 input DM_WE,
	 input [2:0] DMIOp,
	 input clk,
	 input reset,
	 
	 input [31:0] PC
	 
    );

wire [31:0] DMIn;
dmInput DMInput(.A(DM_A[1:0]), .DMIOp(DMIOp), .WD(DM_WD), .DM_Out(DM_Out), .DMIn(DMIn));

dm DM(.A(DM_A), .WD(DMIn), .RD(DM_Out), .RE(DM_RE), .WE(DM_WE), .clk(clk), .Reset(reset), .PC(PC));



endmodule


//
/*
module stageW(
	 

	 
	 input clk,
	 input reset
	 
	 
    );



endmodule


*/