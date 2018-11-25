`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:00 11/22/2018 
// Design Name: 
// Module Name:    mips 
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
 /**/
`define Op 31:26
`define Rs 25:21
`define Rt 20:16
`define Rd 15:11
`define Shamt 10:6
`define Func 5:0

`define Imm 15:0
`define Addr 25:0

module mips(
    input clk,
    input reset
    );


wire [1:0] ForwardRS_D, ForwardRT_D, ForwardRS_E, ForwardRT_E, ForwardRT_M;
wire [31:0] IR_D, IR_E, IR_M, IR_W;
wire GRF_WE_E, GRF_WE_M, GRF_WE_W;
wire [1:0] A3sel_M, A3sel_W, A3sel_E, WDsel_E, WDsel_M, NPCsel_D;
wire [31:0] NPC;
wire Jump;
wire [31:0] PC4_F, NPC_Out, MF_RS_D_Out;
wire pause;
wire [31:0] PC;
wire [31:0] IR_F, /*PC4_F,*/ PC8_F;

wire [31:0] /*IR_D,*/ PC4_D, PC8_D;
wire [1:0] ExtOp_D, NPCOp_D, CMPOp_D;
wire [1:0] ALUasel_D, ALUbsel_D;
wire [3:0] ALUOp_D;
wire DM_RE_D, DM_WE_D, GRF_WE_D;
wire [1:0] A3sel_D, WDsel_D;
wire [31:0] GRF_RD1, GRF_RD2, Ext_Out, PC4_W/*, NPC_Out*/;
wire [31:0] GRF_WD;
wire [4:0] GRF_A3;
wire GRF_WE;
wire [31:0] MF_RT_D_Out;
wire [31:0] ALUOut_M, MUX_WD_Out;
wire [31:0] /*IR_E,*/ PC4_E, PC8_E, Rs_E, Rt_E, Ext_E;

wire [1:0] ExtOp_E, NPCOp_E, CMPOp_E;
wire [1:0] ALUasel_E, ALUbsel_E, NPCsel_E;
wire [3:0] ALUOp_E;
wire DM_RE_E, DM_WE_E;
wire [31:0] MF_RS_E_Out, MF_RT_E_Out;
wire [31:0] ALUa, ALUb;
wire [31:0] ALU_Out;

wire [31:0] /*IR_M,*/ PC4_M, PC8_M, /*ALUOut_M,*/ XALUOut_M, Rt_M;

wire [1:0] ExtOp_M, NPCOp_M, CMPOp_M;
wire [1:0] ALUasel_M, ALUbsel_M, NPCsel_M;
wire [3:0] ALUOp_M;
wire DM_RE_M, DM_WE_M/*, GRF_WE_M*/;

wire [31:0] MF_RT_M_Out;
wire [31:0] DM_Out;

wire [31:0] /*IR_W,*/ PC8_W, ALUOut_W, XALUOut_W, DM_W;

wire [1:0] ExtOp_W, NPCOp_W, CMPOp_W;
wire [1:0] ALUasel_W, ALUbsel_W, NPCsel_W;
wire [3:0] ALUOp_W;
wire DM_RE_W, DM_WE_W/*, GRF_WE_W*/;
wire [1:0] /*A3sel_W,*/ WDsel_W;

wire [4:0] MUX_A3_Out;
//wire [31:0] MUX_WD_Out;
wire [1:0] DMOp_D, DMOp_E, DMOp_M, DMOp_W;

//

forward Forward(
	.IR_D(IR_D), .IR_E(IR_E), .IR_M(IR_M), .IR_W(IR_W), 
	.RWE_E(GRF_WE_E), .A3sel_E(A3sel_E), .RWE_M(GRF_WE_M), .A3sel_M(A3sel_M), .RWE_W(GRF_WE_W), .A3sel_W(A3sel_W),
	.ForwardRS_D(ForwardRS_D), .ForwardRT_D(ForwardRT_D), .ForwardRS_E(ForwardRS_E),
	.ForwardRT_E(ForwardRT_E), .ForwardRT_M(ForwardRT_M)
);

pause Pause(.IR_D(IR_D), .IR_E(IR_E), .IR_M(IR_M), 
				.WDsel_E(WDsel_E), .WDsel_M(WDsel_M), .A3sel_E(A3sel_E),
				.DM_WE_D(DM_WE_D), .DM_RE_E(DM_RE_E), .DM_RE_M(DM_RE_M),
				.GRF_WE_E(GRF_WE_E), .NPCsel_D(NPCsel_D), .pause(pause)
);

// F


mux4 MUX_NPC(.out(NPC), .s(NPCsel_D), .d0(PC4_F), .d1(NPC_Out), .d2(MF_RS_D_Out), .d3(32'bx));

pc ProgramC(.NPC(NPC),  .PC(PC),
		.stall(pause), 
		.clk(clk), .Reset(reset)
);


stageF F(.PC(PC), .clk(clk), .reset(reset),
			.IR_F(IR_F), .PC4_F(PC4_F), .PC8_F(PC8_F));


// D


F_D_reg F_D(.IR_F(IR_F), .PC4_F(PC), .PC8_F(PC8_F), .clk(clk), .stall(pause),
				.IR_D(IR_D), .PC4_D(PC4_D), .PC8_D(PC8_D) );


control ControlD(.IR(IR_D), 
					  .NPCsel(NPCsel_D), .ExtOp(ExtOp_D), .NPCOp(NPCOp_D), .CMPOp(CMPOp_D),
					  .ALUasel(ALUasel_D), .ALUbsel(ALUbsel_D), .ALUOp(ALUOp_D),
					  .DM_RE(DM_RE_D), .DM_WE(DM_WE_D), .DMOp(DMOp_D),
					  .A3sel(A3sel_D), .WDsel(WDsel_D), .GRF_WE(GRF_WE_D));


mux4 MF_RS_D(.s(ForwardRS_D), .out(MF_RS_D_Out), .d0(GRF_RD1), .d1(ALUOut_M), .d2(MUX_WD_Out), .d3(PC8_E));
mux4 MF_RT_D(.s(ForwardRT_D), .out(MF_RT_D_Out), .d0(GRF_RD2), .d1(ALUOut_M), .d2(MUX_WD_Out), .d3(PC8_E));

stageD D(.GRF_A1(IR_D[`Rs]), .GRF_A2(IR_D[`Rt]), .GRF_RD1(GRF_RD1), .GRF_RD2(GRF_RD2),
			.CMP_D1(MF_RS_D_Out), .CMP_D2(MF_RT_D_Out), .CMPOp(CMPOp_D), /*.Jump(Jump),*/
			.Ext_In(IR_D[`Imm]), .Ext_Out(Ext_Out), .ExtOp(ExtOp_D),
			.NPC_PC4(PC4_D), .NPC_Addr(IR_D[`Addr]), .npcOp(NPCOp_D), .NPCOut(NPC_Out),
			.clk(clk), .reset(reset), .PC(PC4_W),
			.GRF_A3(GRF_A3),
			.GRF_WD(GRF_WD),
			.GRF_WE(GRF_WE_W)
);


// E


D_E_reg D_E(.IR_D(IR_D), .PC4_D(PC4_D), .PC8_D(PC8_D), .Rs_D(GRF_RD1), .Rt_D(GRF_RD2), .Ext_D(Ext_Out), .clk(clk), .clr(pause),
				.IR_E(IR_E), .PC4_E(PC4_E), .PC8_E(PC8_E), .Rs_E(Rs_E), .Rt_E(Rt_E), .Ext_E(Ext_E));

control ControlE(.IR(IR_E), 
					  .NPCsel(NPCsel_E), .ExtOp(ExtOp_E), .NPCOp(NPCOp_E), .CMPOp(CMPOp_E),
					  .ALUasel(ALUasel_E), .ALUbsel(ALUbsel_E), .ALUOp(ALUOp_E),
					  .DM_RE(DM_RE_E), .DM_WE(DM_WE_E), .DMOp(DMOp_E),
					  .A3sel(A3sel_E), .WDsel(WDsel_E), .GRF_WE(GRF_WE_E));



mux4 MF_RS_E(.s(ForwardRS_E), .out(MF_RS_E_Out), .d0(Rs_E), .d1(ALUOut_M), .d2(MUX_WD_Out), .d3(32'bx));
mux4 MF_RT_E(.s(ForwardRT_E), .out(MF_RT_E_Out), .d0(Rt_E), .d1(ALUOut_M), .d2(MUX_WD_Out), .d3(32'bx));

mux4 MUX_ALUa(.s(ALUasel_E), .out(ALUa), .d0(MF_RS_E_Out), .d1(0), .d2(MF_RT_E_Out), .d3(32'bx));
mux4 MUX_ALUb(.s(ALUbsel_E), .out(ALUb), .d0(MF_RT_E_Out), .d1(Ext_E), .d2(PC8_E), .d3({{27{1'b0}}, IR_E[`Shamt]}));

stageE E(.ALUa(ALUa), .ALUb(ALUb), .ALUop(ALUOp_E), .ALU_Out(ALU_Out)
);

// M


E_M_reg E_M(.IR_E(IR_E), .PC4_E(PC4_E), .PC8_E(PC8_E), .ALUOut_E(ALU_Out), .XALUOut_E(), .Rt_E(MF_RT_E_Out), .clk(clk),
				.IR_M(IR_M), .PC4_M(PC4_M), .PC8_M(PC8_M), .ALUOut_M(ALUOut_M), .XALUOut_M(XALUOut_M), .Rt_M(Rt_M));



control ControlM(.IR(IR_M), 
					  .NPCsel(NPCsel_M), .ExtOp(ExtOp_M), .NPCOp(NPCOp_M), .CMPOp(CMPOp_M),
					  .ALUasel(ALUasel_M), .ALUbsel(ALUbsel_M), .ALUOp(ALUOp_M),
					  .DM_RE(DM_RE_M), .DM_WE(DM_WE_M), .DMOp(DMOp_M),
					  .A3sel(A3sel_M), .WDsel(WDsel_M), .GRF_WE(GRF_WE_M));


mux4 MF_RT_M(.s(ForwardRT_M), .out(MF_RT_M_Out), .d0(Rt_M), .d1(MUX_WD_Out), .d2(32'bx), .d3(32'bx));

stageM M(.DM_A(ALUOut_M), .DM_WD(MF_RT_M_Out), .DM_Out(DM_Out),
			.DM_RE(DM_RE_M), .DM_WE(DM_WE_M), .DMOp(DMOp_M),
			.clk(clk), .reset(reset), .PC(PC4_M)
);

// W


M_W_reg M_W(.IR_M(IR_M), .PC4_M(PC4_M), .PC8_M(PC8_M), .ALUOut_M(ALUOut_M), .XALUOut_M(XALUOut_M), .DM_M(DM_Out), .clk(clk),
				.IR_W(IR_W), .PC4_W(PC4_W), .PC8_W(PC8_W), .ALUOut_W(ALUOut_W), .XALUOut_W(XALUOut_W), .DM_W(DM_W));



control ControlW(.IR(IR_W), 
					  .NPCsel(NPCsel_W), .ExtOp(ExtOp_W), .NPCOp(NPCOp_W), .CMPOp(CMPOp_W),
					  .ALUasel(ALUasel_W), .ALUbsel(ALUbsel_W), .ALUOp(ALUOp_W),
					  .DM_RE(DM_RE_W), .DM_WE(DM_WE_W), .DMOp(DMOp_W),
					  .A3sel(A3sel_W), .WDsel(WDsel_W), .GRF_WE(GRF_WE_W));



mux4 #(5) MUX_A3(.s(A3sel_W), .out(MUX_A3_Out), .d0(IR_W[`Rd]), .d1(IR_W[`Rt]), .d2(IR_W[`Rs]), .d3(5'd31));
mux4 MUX_WD(.s(WDsel_W), .out(MUX_WD_Out), .d0(ALUOut_W), .d1(DM_W), .d2(PC8_W), .d3(32'bx));

assign GRF_A3 = MUX_A3_Out;
assign GRF_WD = MUX_WD_Out;

endmodule