`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:18:46 12/06/2018 
// Design Name: 
// Module Name:    exception 
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
`include "macro.v"

module exceptionF(
	 input [31:0] PC_F,
	 output Exc_F,
	 output [4:0] ExcCode_F
    );

wire overflow = !(
					(PC_F >= 32'h0000_3000 && PC_F <= 32'h0000_4FFF) 
					) ? 1 : 0;

wire not_align = PC_F[1:0] != 0;

assign Exc_F = overflow || not_align;

assign ExcCode_F = Exc_F ? `AdEL : 5'bx;

endmodule


//

module exceptionD(
	 input [31:0] IR,
	 output Exc_D,
	 output [4:0] ExcCode_D
    );

wire normal = (IR[`Op] >= 2 && IR[`Op] <= 15) ||
				  (IR[`Op] == 32) || (IR[`Op] == 33) ||
				  (IR[`Op] == 35) || (IR[`Op] == 36) || (IR[`Op] == 37) ||
				  (IR[`Op] == 40) || (IR[`Op] == 41) ||
				  (IR[`Op] == 43);
				  
wire rs = (IR[`Op] == 16) && (
			  IR[`Rs] == 0 ||
			  IR[`Rs] == 4 
			 );
wire eret = IR == `eret;

wire rt = (IR[`Op] == 1) && (
			  IR[`Rt] == 0 ||
			  IR[`Rt] == 1 
			 );

wire r =  (IR[`Op] == 0) && (
			  IR[`Func] == 0 || IR[`Func] == 2 || IR[`Func] == 3 || IR[`Func] == 4 || IR[`Func] == 6 || IR[`Func] == 7 ||
 IR[`Func] == 8 || IR[`Func] == 9 || IR[`Func] == 12 || IR[`Func] == 13 ||
 IR[`Func] == 16 || IR[`Func] == 17 || IR[`Func] == 18 || IR[`Func] == 19 ||
 IR[`Func] == 24 || IR[`Func] == 25 || IR[`Func] == 26 || IR[`Func] == 27 ||
 IR[`Func] == 32 || IR[`Func] == 33 || IR[`Func] == 34 || IR[`Func] == 35 || IR[`Func] == 36 || IR[`Func] == 37 || IR[`Func] == 38 ||
 IR[`Func] == 39 || IR[`Func] == 42 || IR[`Func] == 43
			 );

assign Exc_D = !(normal || rs || eret || rt || r);

assign ExcCode_D = Exc_D ? `AdEL : 5'bx;

endmodule


//
module exceptionE(
	 input [31:0] IR_E,
	 input Overflow,
	 output Exc_E,
	 output [4:0] ExcCode_E
    );

wire cal = IR_E[`Op] == `R ? (
						// R
						IR_E[`Func] == `add 	? 1 :
						IR_E[`Func] == `sub 	? 1 :
						0 ) : 
					 IR_E[`Op] == `addi 	? 1 :
					 0;
wire load = IR_E[`Op] == `lw ? 1 :
				IR_E[`Op] == `lb ? 1 :
				IR_E[`Op] == `lbu ? 1 :
				IR_E[`Op] == `lh ? 1 :
				IR_E[`Op] == `lhu ? 1 :
				0;

wire save = IR_E[`Op] == `sw ? 1 :
				IR_E[`Op] == `sb ? 1 :
				IR_E[`Op] == `sh ? 1 :
				0;

assign Exc_E = Overflow === 1 && (cal || load || save);

assign ExcCode_E = cal ? `Ov :
						 load ? `AdEL :
						 save ? `AdES :
						 5'bx;



endmodule


//
module exceptionM(
	 input [31:0] IR_M,
	 input [31:0] A,
	 input RE, WE,
	 output Exc_M,
	 output [4:0] ExcCode_M
    );

wire load = IR_M[`Op] == `lw ? 1 :
				IR_M[`Op] == `lb ? 1 :
				IR_M[`Op] == `lbu ? 1 :
				IR_M[`Op] == `lh ? 1 :
				IR_M[`Op] == `lhu ? 1 :
				0;

wire save = IR_M[`Op] == `sw ? 1 :
				IR_M[`Op] == `sb ? 1 :
				IR_M[`Op] == `sh ? 1 :
				0;

wire AOverflow = !(
					(A >= 32'h0000_0000 && A <= 32'h0000_2FFF) ||
					(A >= 32'h0000_7F00 && A <= 32'h0000_7F0B) ||
					(A >= 32'h0000_7F10 && A <= 32'h0000_7F1B) 
					);

wire NowriteA = (A >= 32'h0000_7F08 && A <= 32'h0000_7F0B) ||
					 (A >= 32'h0000_7F18 && A <= 32'h0000_7F1B);

wire illwrite = NowriteA && save;

wire w = IR_M[`Op] == `sw ||
			IR_M[`Op] == `lw;
wire h = IR_M[`Op] == `sh ||
			IR_M[`Op] == `lh ||
			IR_M[`Op] == `lhu;
			
wire timer = (A >= 32'h0000_7F00 && A <= 32'h0000_7F0B) ||
					(A >= 32'h0000_7F10 && A <= 32'h0000_7F1B);
					
wire illtimer = timer && (IR_M[`Op] == `sh ||
								  IR_M[`Op] == `sb || 
								  IR_M[`Op] == `lh || 
								  IR_M[`Op] == `lhu || 
								  IR_M[`Op] == `lb ||
								  IR_M[`Op] == `lbu
								  );

wire not_align_w = w && A[1:0] != 0;
wire not_align_h = h && A[1:0] != 0 && A[1:0] != 2;

assign Exc_M = (AOverflow || not_align_w || not_align_h || illwrite || illtimer) && (RE || WE);



assign ExcCode_M = load && RE ? `AdEL :
						 save && WE ? `AdES :
						 5'bx;

endmodule


