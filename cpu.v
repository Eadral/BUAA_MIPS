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
`include "macro.v"

module cpu(
    input clk,
    input reset,
	 
	 output [31:0] PrAddr,
	 output [31:0] PrWD,
	 input [31:0] PrRD,
	 output PrWE,
	 input [7:2] HWInt
    );
	
wire [31:0] Bridge_Out;
wire [31:0] GRF_WD, MUX_WD_Out;

wire [1:0] ForwardRS_D, ForwardRT_D, ForwardRS_E, ForwardRT_E, ForwardRT_M;
wire [31:0] IR_D, IR_E, IR_M, IR_W;
wire GRF_WE_E, GRF_WE_M, GRF_WE_W;
wire [2:0] A3sel_D, A3sel_M, A3sel_W, A3sel_E;
wire [1:0] WDsel_E, WDsel_M, NPCsel_D;
wire [31:0] NPC;
wire Jump_D, Jump_E;
wire [31:0] PC4_F, NPC_Out, MF_RS_D_Out;
wire pause;
wire [31:0] PC;
wire [31:0] IR_F, /*PC4_F,*/ PC8_F;

wire [31:0] /*IR_D,*/ PC_D, PC8_D;
wire [1:0] ExtOp_D, NPCOp_D;
wire [1:0] ALUasel_D, ALUbsel_D;
wire [3:0] ALUOp_D, CMPOp_D;
wire DM_RE_D, DM_WE_D, GRF_WE_D;
wire [1:0] WDsel_D;
wire [31:0] GRF_RD1, GRF_RD2, Ext_Out, PC_W/*, NPC_Out*/;

wire [4:0] GRF_A3;
wire GRF_WE;
wire [31:0] MF_RT_D_Out;
wire [31:0] ALUOut_M;
wire [31:0] /*IR_E,*/ PC_E, PC8_E, Rs_E, Rt_E, Ext_E;

wire [1:0] ExtOp_E, NPCOp_E;
wire [1:0] ALUasel_E, ALUbsel_E, NPCsel_E;
wire [3:0] ALUOp_E, CMPOp_E;
wire DM_RE_E, DM_WE_E;
wire [31:0] MF_RS_E_Out, MF_RT_E_Out;
wire [31:0] ALUa, ALUb;
wire [31:0] ALU_Out;

wire [31:0] /*IR_M,*/ PC_M, PC8_M, /*ALUOut_M,*/ XALUOut_M, Rt_M;

wire [1:0] ExtOp_M, NPCOp_M;
wire [1:0] ALUasel_M, ALUbsel_M, NPCsel_M;
wire [3:0] ALUOp_M, CMPOp_M;
wire DM_RE_M, DM_WE_M/*, GRF_WE_M*/;

wire [31:0] MF_RT_M_Out;
wire [31:0] DM_Out;

wire [31:0] /*IR_W,*/ PC8_W, ALUOut_W, XALUOut_W, DM_W;

wire [1:0] ExtOp_W, NPCOp_W;
wire [1:0] ALUasel_W, ALUbsel_W, NPCsel_W;
wire [3:0] ALUOp_W, CMPOp_W;
wire DM_RE_W, DM_WE_W/*, GRF_WE_W*/;
wire [1:0] /*A3sel_W,*/ WDsel_W;

wire [4:0] A3_E, A3_M, A3_W;
//wire [31:0] MUX_WD_Out;
wire [2:0] DMOOp_D, DMOOp_E, DMOOp_M, DMOOp_W;
wire [2:0] DMIOp_D, DMIOp_E, DMIOp_M, DMIOp_W;

wire [31:0] GRF_RD1_Out, GRF_RD2_Out;
wire [31:0] DMOut;

wire [3:0] XALUOp_D, XALUOp_E, XALUOp_M, XALUOp_W;
wire [31:0] XALU_Out;
wire Busy;

wire [1:0] Tnew_D, Tnew_E, Tnew_M, Tnew_W, Tuse_Rs_D, Tuse_Rt_D;

wire Exc_F, Exc_D, Exc_E, Exc_M;
wire Exc_FD, Exc_DE, Exc_EM;
wire [4:0] ExcCode_F, ExcCode_D, ExcCode_E, ExcCode_M;
wire [4:0] ExcCode_FD, ExcCode_DE, ExcCode_EM;

wire [31:0] MUX_NPC_Out, MUX_NPC_CP0_Out, MUX_ERET_Out;
wire [31:0] EPC;

wire [31:0] CP0_Out, CP0_W;
wire CP0_WE_E, CP0_WE_M;

wire slot_F, slot_D, slot_E, slot_M;

wire Start;

wire [31:0] MF_EPC_Out;
wire [1:0] Forward_EPC;

wire eret_nop;
//

forward Forward(
	.IR_D(IR_D), .IR_E(IR_E), .IR_M(IR_M), .IR_W(IR_W), 
	.RWE_E(GRF_WE_E), .RWE_M(GRF_WE_M), .RWE_W(GRF_WE_W),
	.A3_E(A3_E), .A3_M(A3_M), .A3_W(A3_W),
	.ForwardRS_D(ForwardRS_D), .ForwardRT_D(ForwardRT_D), .ForwardRS_E(ForwardRS_E),
	.ForwardRT_E(ForwardRT_E), .ForwardRT_M(ForwardRT_M),
	.Forward_RD1(Forward_RD1), .Forward_RD2(Forward_RD2),
	.CP0_WE_E(CP0_WE_E), .CP0_WE_M(CP0_WE_M), .Forward_EPC(Forward_EPC)
);

pause Pause(.Tuse_Rs_D(Tuse_Rs_D), .Tuse_Rt_D(Tuse_Rt_D), .Tnew_E(Tnew_E), .Tnew_M(Tnew_M), .Tnew_W(Tnew_W),
				.IR_D(IR_D), .IR_E(IR_E), .IR_M(IR_M), .IR_W(IR_W),
				.A3_E(A3_E), .A3_M(A3_M), .A3_W(A3_W),
				.GRF_WE_E(GRF_WE_E), .GRF_WE_M(GRF_WE_M), .GRF_WE_W(GRF_WE_W), 
				.CP0_WE_E(CP0_WE_E), .CP0_WE_M(CP0_WE_M),
				.WDsel_E(WDsel_E), .WDsel_M(WDsel_M), 
				.DM_WE_D(DM_WE_D), .DM_RE_E(DM_RE_E), .DM_RE_M(DM_RE_M),
				.NPCsel_D(NPCsel_D), 
				.Busy(Busy || (XALUOp_E > 0 && XALUOp_E < 3) || XALUOp_E > 6), .XALUOp_D(XALUOp_D),
				.pause(pause),
				.IntReq(IntReq)
);

// F


mux4 MUX_NPC(.out(MUX_NPC_Out), .s(NPCsel_D), .d0(PC4_F), .d1(NPC_Out), .d2(MF_RS_D_Out), .d3(32'bx));

mux2 MUX_NPC_CP0(.out(MUX_NPC_CP0_Out), .s(IntReq), .d0(MUX_NPC_Out), .d1(32'h0000_4180));

//mux4 MF_EPC(.out(MF_EPC_Out), .s(Forward_EPC), .d0(EPC), .d1(MF_RT_E_Out), .d2(MF_RT_M_Out) );

mux2 MUX_ERET(.out(NPC), .s(eret_D), .d0(MUX_NPC_CP0_Out), .d1(EPC));

pc ProgramC(.NPC(NPC),  .PC(PC),
		.stall(pause), 
		.clk(clk), .Reset(reset)
);


stageF F(.PC(PC), .clk(clk), .reset(reset),
			.IR_F(IR_F), .PC4_F(PC4_F), .PC8_F(PC8_F));

exceptionF ExceptionF(
    .PC_F(PC), 
    .Exc_F(Exc_F), 
    .ExcCode_F(ExcCode_F)
    );

// D

assign eret_nop = IR_D == `eret && !(pause === 1);
F_D_reg F_D(.IR_F(IR_F), .PC_F(PC), .PC8_F(PC8_F), .clk(clk), .stall(pause), .reset(reset || IntReq), .clr(Likely_D && Jump_D),
				.IR_D(IR_D), .PC_D(PC_D), .PC8_D(PC8_D), 
				.Exc_F(Exc_F), .ExcCode_F(ExcCode_F), .Exc_D(Exc_FD), .ExcCode_D(ExcCode_FD),
				.slot_F(!(NPCsel_D === 0)), .slot_D(slot_D)
				);


control ControlD(.IR(IR_D), 
					  .NPCsel(NPCsel_D), .ExtOp(ExtOp_D), .NPCOp(NPCOp_D), .CMPOp(CMPOp_D),
					  .ALUasel(ALUasel_D), .ALUbsel(ALUbsel_D), .ALUOp(ALUOp_D), .XALUOp(XALUOp_D),
					  .DM_RE(DM_RE_D), .DM_WE(DM_WE_D), .DMOOp(DMOOp_D), .DMIOp(DMIOp_D),
					  .A3sel(A3sel_D), .WDsel(WDsel_D), .GRF_WE(GRF_WE_D),
					  .Tnew(Tnew_D), .Tuse_Rs(Tuse_Rs_D), .Tuse_Rt(Tuse_Rt_D),
					  .eret(eret_D)
					  );

mux2 MF_RD1(.s(Forward_RD1), .out(GRF_RD1), .d0(GRF_RD1_Out), .d1(GRF_WD));
mux2 MF_RD2(.s(Forward_RD2), .out(GRF_RD2), .d0(GRF_RD2_Out), .d1(GRF_WD));

mux4 MF_RS_D(.s(ForwardRS_D), .out(MF_RS_D_Out), .d0(GRF_RD1), .d1(ALUOut_M), .d2(MUX_WD_Out), .d3(PC8_E));
mux4 MF_RT_D(.s(ForwardRT_D), .out(MF_RT_D_Out), .d0(GRF_RD2), .d1(ALUOut_M), .d2(MUX_WD_Out), .d3(PC8_E));

stageD D(.GRF_A1(IR_D[`Rs]), .GRF_A2(IR_D[`Rt]), .GRF_RD1(GRF_RD1_Out), .GRF_RD2(GRF_RD2_Out),
			.CMP_D1(MF_RS_D_Out), .CMP_D2(MF_RT_D_Out), .CMPOp(CMPOp_D), .Jump(Jump_D),
			.Ext_In(IR_D[`Imm]), .Ext_Out(Ext_Out), .ExtOp(ExtOp_D),
			.NPC_PC(PC_D), .NPC_Addr(IR_D[`Addr]), .npcOp(NPCOp_D), .NPCOut(NPC_Out),
			.clk(clk), .reset(reset), .PC(PC_W),
			.GRF_A3(GRF_A3),
			.GRF_WD(GRF_WD),
			.GRF_WE(GRF_WE_W)
);

exceptionD ExceptionD (
    .IR(IR_D), 
    .Exc_D(Exc_D), 
    .ExcCode_D(ExcCode_D)
    );


// E


D_E_reg D_E(.IR_D(IR_D), .PC_D(PC_D), .PC8_D(PC8_D), .Rs_D(MF_RS_D_Out), .Rt_D(MF_RT_D_Out), .Ext_D(Ext_Out), .clk(clk), .clr(pause), .reset(reset || IntReq), .Tnew_D(Tnew_D), .Jump_D(Jump_D), .pause_D(pause),
				.IR_E(IR_E), .PC_E(PC_E), .PC8_E(PC8_E), .Rs_E(Rs_E), .Rt_E(Rt_E), .Ext_E(Ext_E), .Tnew_E(Tnew_E), .Jump_E(Jump_E), .pause_E(pause_E),
				.Exc_D(Exc_FD || Exc_D), .ExcCode_D(Exc_FD ? ExcCode_FD : ExcCode_D), .Exc_E(Exc_DE), .ExcCode_E(ExcCode_DE),
				.slot_D(slot_D), .slot_E(slot_E)
				);

control ControlE(.IR(IR_E), 
					  .NPCsel(NPCsel_E), .ExtOp(ExtOp_E), .NPCOp(NPCOp_E), .CMPOp(CMPOp_E),
					  .ALUasel(ALUasel_E), .ALUbsel(ALUbsel_E), .ALUOp(ALUOp_E), .XALUOp(XALUOp_E),
					  .DM_RE(DM_RE_E), .DM_WE(DM_WE_E), .DMOOp(DMOOp_E), .DMIOp(DMIOp_E),
					  .A3sel(A3sel_E), .WDsel(WDsel_E), .GRF_WE(GRF_WE_E),
					  .eret(eret_E), 
					  .CP0_WE(CP0_WE_E)					  
					  );

mux4 MF_RS_E(.s(ForwardRS_E), .out(MF_RS_E_Out), .d0(Rs_E), .d1(ALUOut_M), .d2(MUX_WD_Out), .d3(32'bx));
mux4 MF_RT_E(.s(ForwardRT_E), .out(MF_RT_E_Out), .d0(Rt_E), .d1(ALUOut_M), .d2(MUX_WD_Out), .d3(32'bx));

mux4 MUX_ALUa(.s(ALUasel_E), .out(ALUa), .d0(MF_RS_E_Out), .d1({{27{1'b0}}, IR_E[`Shamt]}), .d2(XALU_Out), .d3(32'bx));
mux4 MUX_ALUb(.s(ALUbsel_E), .out(ALUb), .d0(MF_RT_E_Out), .d1(Ext_E), .d2(PC8_E), .d3(32'bx));

assign Start_E = ((XALUOp_E > 0 && XALUOp_E < 5) || XALUOp_E > 6) && !(IntReq === 1);
stageE E(.ALUa(ALUa), .ALUb(ALUb), .ALUop(ALUOp_E), .ALU_Out(ALU_Out), .Overflow(Overflow),
			.XALUa(MF_RS_E_Out), .XALUb(MF_RT_E_Out), .XALUOp(XALUOp_E), .Start(Start_E), .XALU_Out(XALU_Out), .Busy(Busy),
			.clk(clk), .reset(reset), .rollback(rollback)
);

mux8 #(5) MUX_A3(.s(A3sel_E), .out(A3_E), 
					  .d0(IR_E[`Rd]), .d1(IR_E[`Rt]), .d2(IR_E[`Rs]), .d3(5'd31),
					  .d4(MF_RT_E_Out == 0 ? IR_E[`Rd] : 5'b0),
					  .d5(Jump_E ? 5'd31 : 5'b0), .d6(5'bx), .d7(5'bx)
					  );

exceptionE ExceptionE (
	 .IR_E(IR_E),
    .Overflow(Overflow), 
    .Exc_E(Exc_E), 
    .ExcCode_E(ExcCode_E)
    );

// M


E_M_reg E_M(.IR_E(IR_E), .PC_E(PC_E), .PC8_E(PC8_E), .ALUOut_E(ALU_Out), .XALUOut_E(ALU_Out), .Rt_E(MF_RT_E_Out), .clk(clk), .reset(reset || IntReq), .A3_E(A3_E), .Tnew_E(Tnew_E), .Start_E(Start_E), .pause_E(pause_E),
				.IR_M(IR_M), .PC_M(PC_M), .PC8_M(PC8_M), .ALUOut_M(ALUOut_M), .XALUOut_M(XALUOut_M), .Rt_M(Rt_M), .A3_M(A3_M), .Tnew_M(Tnew_M), .Start_M(Start_M), .pause_M(pause_M),
				.Exc_E(Exc_DE || Exc_E), .ExcCode_E(Exc_DE ? ExcCode_DE : ExcCode_E), .Exc_M(Exc_EM), .ExcCode_M(ExcCode_EM),
				.slot_E(slot_E), .slot_M(slot_M)
				);



control ControlM(.IR(IR_M), 
					  .NPCsel(NPCsel_M), .ExtOp(ExtOp_M), .NPCOp(NPCOp_M), .CMPOp(CMPOp_M),
					  .ALUasel(ALUasel_M), .ALUbsel(ALUbsel_M), .ALUOp(ALUOp_M), .XALUOp(XALUOp_M),
					  .DM_RE(DM_RE_M), .DM_WE(DM_WE_M), .DMOOp(DMOOp_M), .DMIOp(DMIOp_M),
					  .A3sel(A3sel_M), .WDsel(WDsel_M), .GRF_WE(GRF_WE_M),
					  .CP0_WE(CP0_WE_M), .eret(eret_M)
					  );


mux4 MF_RT_M(.s(ForwardRT_M), .out(MF_RT_M_Out), .d0(Rt_M), .d1(MUX_WD_Out), .d2(32'bx), .d3(32'bx));

assign PrAddr = ALUOut_M;
assign PrWD = MF_RT_M_Out;
assign PrWE = DM_WE_M;

stageM M(.DM_A(ALUOut_M), .DM_WD(MF_RT_M_Out), .DM_Out(DM_Out),
			.DM_RE(DM_RE_M), .DM_WE(DM_WE_M && !(IntReq === 1)), .DMIOp(DMIOp_M),
			.clk(clk), .reset(reset), .PC(PC_M)
);

assign Bridge_Out = PrAddr > 32'h4FFFF ? PrWD : DM_Out;

exceptionM ExceptionM (
	 .IR_M(IR_M),
    .A(ALUOut_M), 
	 .RE(DM_RE_M),
    .WE(DM_WE_M), 
    .Exc_M(Exc_M), 
    .ExcCode_M(ExcCode_M)
    );

assign rollback = Start_M && IntReq ? 1 : 0;
cp0 CP0 (
	 .IR_M(IR_M), .IR_E(IR_E), .IR_D(IR_D),
    .RA(IR_M[`Rd]), 
    .WA(IR_M[`Rd]), 
    .DIn(MF_RT_M_Out), 
    .DOut(CP0_Out), 
    .reset(reset), 
    .clk(clk), 
    .WE(CP0_WE_M), 
    .PC_M(PC_M), .PC_E(PC_E), .PC_D(PC_D), 
	 .Exc(Exc_EM || Exc_M),
    .ExcCode(Exc_M ? ExcCode_M : ExcCode_EM), 
    .HWInt(HWInt), 
    .IntReq(IntReq), 
    .EPC(EPC),
	 .eret(eret_M),
	 .slot(slot_M),
	 .pause_M(pause_M), .pause_E(pause_E)
    );

// W


M_W_reg M_W(.IR_M(IR_M), .PC_M(PC_M), .PC8_M(PC8_M), .ALUOut_M(ALUOut_M), .XALUOut_M(XALUOut_M), .DM_M(Bridge_Out), .clk(clk), .reset(reset || IntReq), .A3_M(A3_M), .Tnew_M(Tnew_M), .CP0_M(CP0_Out),
				.IR_W(IR_W), .PC_W(PC_W), .PC8_W(PC8_W), .ALUOut_W(ALUOut_W), .XALUOut_W(XALUOut_W), .DM_W(DM_W), .A3_W(A3_W), .Tnew_W(Tnew_W), .CP0_W(CP0_W));



control ControlW(.IR(IR_W), 
					  .NPCsel(NPCsel_W), .ExtOp(ExtOp_W), .NPCOp(NPCOp_W), .CMPOp(CMPOp_W),
					  .ALUasel(ALUasel_W), .ALUbsel(ALUbsel_W), .ALUOp(ALUOp_W), .XALUOp(XALUOp_W),
					  .DM_RE(DM_RE_W), .DM_WE(DM_WE_W), .DMOOp(DMOOp_W), .DMIOp(DMIOp_W),
					  .A3sel(A3sel_W), .WDsel(WDsel_W), .GRF_WE(GRF_WE_W),
					  .CP0_WE(CP0_WE_W)
					  );

dmOutput DMOutput(.A(ALUOut_W[1:0]), .DMOOp(DMOOp_W), .RD(DM_W), .DMOut(DMOut));

//mux4 #(5) MUX_A3(.s(A3sel_W), .out(MUX_A3_Out), .d0(IR_W[`Rd]), .d1(IR_W[`Rt]), .d2(IR_W[`Rs]), .d3(5'd31));
mux4 MUX_WD(.s(WDsel_W), .out(MUX_WD_Out), .d0(ALUOut_W), .d1(DMOut), .d2(PC8_W), .d3(CP0_W));

assign GRF_A3 = A3_W;
assign GRF_WD = MUX_WD_Out;

endmodule
