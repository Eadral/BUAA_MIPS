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
	 input [1:0] CMPOp,

	 input [15:0] Ext_In,
	 output [31:0] Ext_Out,
	 input [1:0] ExtOp,
	 
	 input [31:0] NPC_PC4,
	 input [25:0] NPC_Addr,
	 input [1:0] npcOp,
	 output [31:0] NPCOut,
	 
	 input clk,
	 input reset,
	 
	 input [4:0] GRF_A3,
	 input [31:0] GRF_WD,
	 input GRF_WE,
	 
	 input [31:0] PC
    );
	 
	 
grf GRF(.RA1(GRF_A1), .RA2(GRF_A2), .WA(GRF_A3), .WD(GRF_WD), .RD1(GRF_RD1), .RD2(GRF_RD2), .Reset(reset), .clk(clk), .WE(GRF_WE), .PC(PC));

cmp CMP(.A(CMP_D1), .B(CMP_D2), .Op(CMPOp), .Zero(Jump));

ext Ext(.In(Ext_In), .Out(Ext_Out), .Op(ExtOp));

npc NPC(.PC(NPC_PC4), .Add(NPC_Addr), .npcOp(npcOp), .Jump(Jump), .NPC(NPCOut));

endmodule

//


module stageE(
	 
	 input [31:0] ALUa,
	 input [31:0] ALUb,
	 input [3:0] ALUop,
	 output [31:0] ALU_Out
	
    );


alu ALU(.A(ALUa), .B(ALUb), .Op(ALUop), .Out(ALU_Out), .Zero());


endmodule

//


module stageM(
	 
	 
	 input [31:0] DM_A,
	 input [31:0] DM_WD,
	 output reg [31:0] DM_Out,
	 input DM_RE,
	 input DM_WE,
	 input [1:0] DMOp,
	 input clk,
	 input reset,
	 
	 input [31:0] PC
	 
    );

wire [31:0] MUX_SB_OUT;
mux4 MUX_SB(.out(MUX_SB_OUT), .s(DM_A[1:0]),
				.d0({DM_Out[31:8], DM_WD[7:0]}), .d1({DM_Out[31:16], DM_WD[7:0], DM_Out[7:0]}),
				.d2({DM_Out[31:24], DM_WD[7:0], DM_Out[15:0]}), .d3({DM_WD[7:0], DM_Out[23:0]}) );

wire [31:0] MUX_DM_WD_Out;
muxe #(2) MUX_DM_WD(.out(MUX_DM_WD_Out), .s(DMOp), .e(2'b01),
						  .d0(DM_WD), .d1(MUX_SB_OUT));

wire [31:0] DM_Out_dm;
dm DM(.A(DM_A), .WD(MUX_DM_WD_Out), .RD(DM_Out_dm), .RE(DM_RE), .WE(DM_WE), .clk(clk), .Reset(reset), .PC(PC));

wire [31:0] MUX_LB_Out;
mux4 MUX_LB(.out(MUX_LB_Out), .s(DM_A[1:0]),
			   .d0({{24{DM_Out_dm[7]}}, DM_Out_dm[7:0]}),
			   .d1({{24{DM_Out_dm[15]}}, DM_Out_dm[15:8]}),
			   .d2({{24{DM_Out_dm[23]}}, DM_Out_dm[23:16]}),
			   .d3({{24{DM_Out_dm[31]}}, DM_Out_dm[31:24]})
				);

wire [31:0] MUX_LBU_Out;
mux4 MUX_LBU(.out(MUX_LBU_Out), .s(DM_A[1:0]),
			   .d0({{24{1'b0}}, DM_Out_dm[7:0]}),
			   .d1({{24{1'b0}}, DM_Out_dm[15:8]}),
			   .d2({{24{1'b0}}, DM_Out_dm[23:16]}),
			   .d3({{24{1'b0}}, DM_Out_dm[31:24]})
				);

always @(*)
case (DMOp)
	2: DM_Out = MUX_LB_Out;
	3: DM_Out = MUX_LBU_Out;
	default: DM_Out = DM_Out_dm;
endcase

endmodule


//
/*
module stageW(
	 

	 
	 input clk,
	 input reset
	 
	 
    );



endmodule


*/