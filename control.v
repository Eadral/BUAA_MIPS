`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:10:11 11/23/2018 
// Design Name: 
// Module Name:    control 
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
`define Op 31:26
`define Rs 25:21
`define Rt 20:16
`define Rd 15:11
`define Shamt 10:6
`define Func 5:0

`define Imm 15:0
`define Addr 25:0

`define x 32'bx

// macro
`define R 6'b000000

// normal
`define lw 		6'b100011
`define lb 		6'b100000
`define lbu 	6'b100100
`define sw 		6'b101011
`define sb 		6'b101000
`define sh 		6'b101001
`define lh 		6'b100001
`define lhu		6'b100101

`define beq		6'b000100
`define bgtz	6'b000111
`define blez	6'b000110
`define bne		6'b000101
`define j		6'b000010
`define jal		6'b000011

// R
`define mult	6'b011000
`define multu	6'b011001
`define div 	6'b011010
`define divu	6'b011011
`define mthi	6'b010001
`define mtlo	6'b010011
`define mfhi	6'b010000
`define mflo	6'b010010

`define jalr	6'b001001
`define jr		6'b001000


// Rt
`define bgez	5'b00001
`define bltz	5'b00000

module control(
	 input [31:0] IR,
	 
	 output reg [1:0] NPCsel,
	 output reg [1:0] NPCOp,
	 output reg [3:0] CMPOp,
	 output reg [1:0] ExtOp,

	 
	 output reg [1:0] ALUasel,
	 output reg [1:0] ALUbsel,
	 output reg [3:0] ALUOp,
	 output [3:0] XALUOp,
	 
	 output DM_RE,
	 output DM_WE,
	 output [2:0] DMOOp, DMIOp,
	 
	 output reg [2:0] A3sel,
	 output reg [1:0] WDsel,
	 output reg GRF_WE,
	 
	 output reg [1:0] Tnew, Tuse_Rs, Tuse_Rt
    );


// Branch or Jump



// XALU
assign XALUOp = IR[`Op] == `R ? (
						// R
						IR[`Func] == `mult	? 1 :
						IR[`Func] == `multu	? 2 :
						IR[`Func] == `div 	? 7 :
						IR[`Func] == `divu	? 8 :
						IR[`Func] == `mthi	? 3 :
						IR[`Func] == `mtlo	? 4 :
						IR[`Func] == `mfhi	? 5 :
						IR[`Func] == `mflo	? 6 :
						`x
					 ) : 
					 `x;

// DM
assign DM_RE = IR[`Op] == `lw 	? 1 :
				   IR[`Op] == `lb 	? 1 :
				   IR[`Op] == `lbu 	? 1 :
				   IR[`Op] == `lh 	? 1 :
				   IR[`Op] == `sb 	? 1 :
				   IR[`Op] == `sh 	? 1 :
			      0;
					
assign DM_WE = IR[`Op] == `sw 	? 1 :
				   IR[`Op] == `sb 	? 1 :
				   IR[`Op] == `sh 	? 1 :
			      0;

assign DMOOp = IR[`Op] == `lw 	? 0 :
					IR[`Op] == `lb 	? 2 :
					IR[`Op] == `lbu	? 1 :
					IR[`Op] == `sw 	? 0 :
					IR[`Op] == `sb		? 0 :
					IR[`Op] == `lh 	? 4 :
					IR[`Op] == `lhu 	? 3 :
					`x ;
					

assign DMIOp = IR[`Op] == `lw ? 0 :
					IR[`Op] == `lb ? 0 :
					IR[`Op] == `lbu ? 0 :
					IR[`Op] == `sw ? 0 :
					IR[`Op] == `sb ? 1 :
					IR[`Op] == `sh ? 2 :
					`x;

// Ext, ALU, GRF | T

always @(*) begin
case (IR[`Op])
	6'b000000: begin
		case (IR[`Func]) 
			`mult: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end		
			
			`multu: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end		
			
			`div: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end		
			
			`divu: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end		
			
			`mthi: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end		
			
			`mtlo: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end		

			`mfhi: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 2;
				ALUbsel	= `x;
				ALUOp		= 4'b1011;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end			
			
			`mflo: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 2;
				ALUbsel	= `x;
				ALUOp		= 4'b1011;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end	
			
			6'b100001: begin: addu
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0000;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end	
			
			6'b100000: begin: add
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0000;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b100011: begin: subu
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0001;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b100010: begin: sub
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0001;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b101010: begin: slt
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0111;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b101011: begin: sltu
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b1000;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b000000: begin: sll
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 1;
				ALUbsel	= 0;
				ALUOp		= 4'b0110;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b000011: begin: sra
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 1;
				ALUbsel	= 0;
				ALUOp		= 4'b0101;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b00010: begin: srl
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 1;
				ALUbsel	= 0;
				ALUOp		= 4'b0100;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b100100: begin: and_
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0010;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b100111: begin: nor_
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b1001;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b100101: begin: or_
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0011;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b100110: begin: xor_
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b1010;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b000100: begin: sllv
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0110;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b000111: begin: srav
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0101;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b000110: begin: srlv
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0100;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 1;
				Tuse_Rs	= 1;
				Tuse_Rt	= 1;
			end
			
			6'b001001: begin: jalr
				NPCsel	= 2;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= 2;
				ALUOp		= 4'b1100;
			
				 				 				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
				
				Tnew		= 0;
				Tuse_Rs	= 0;
				Tuse_Rt	= 3;
			end
			
			6'b001000: begin: jr
				NPCsel	= 2;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
				
				Tnew		= 0;
				Tuse_Rs	= 0;
				Tuse_Rt	= 3;
			end
			
			default: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= 4'bxxxx;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end
		endcase
	end
	
	6'b000001: begin
		case (IR[`Rt]) 
			5'b00001: begin: bgez
				NPCsel	= 1;
				NPCOp		= 0;
				CMPOp		= 1;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= `x;
				
				Tnew		= 0;
				Tuse_Rs	= 0;
				Tuse_Rt	= 3;
			end
			
			5'b00000: begin: bltz
				NPCsel	= 1;
				NPCOp		= 0;
				CMPOp		= 4;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= `x;
				
				Tnew		= 0;
				Tuse_Rs	= 0;
				Tuse_Rt	= 3;
			end
			
			default: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= 4'bxxxx;
			
				 				 				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
				
				Tnew		= 0;
				Tuse_Rs	= 3;
				Tuse_Rt	= 3;
			end
			
		endcase
	end
	
	6'b101011: begin: sw
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
		
		Tnew		= 0;
		Tuse_Rs	= 1;
		Tuse_Rt	= 1;
	end
	
	6'b101000: begin: sb
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
		
		Tnew		= 0;
		Tuse_Rs	= 1;
		Tuse_Rt	= 1;
	end
	
	6'b101001: begin: sh
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
		
		Tnew		= 0;
		Tuse_Rs	= 1;
		Tuse_Rt	= 1;
	end
	
	6'b100011: begin: lw
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
		
		Tnew		= 2;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b100000: begin: lb
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
		
		Tnew		= 2;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b100100: begin: lbu
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
		
		Tnew		= 2;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	`lh: begin: lh
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
		
		Tnew		= 2;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	`lhu: begin: lhu
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
		
		Tnew		= 2;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b001010: begin: slti
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0111;
	
		 	    		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
		
		Tnew		= 1;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b001011: begin: sltiu
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b1000;
	
		 	    		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
		
		Tnew		= 1;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b001100: begin: andi
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0010;
	
		 	    		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
		
		Tnew		= 1;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b001101: begin: ori
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0011;
	
		 	    		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
		
		Tnew		= 1;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b001110: begin: xori
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b1010;
	
		 	    		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
		
		Tnew		= 1;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b001111: begin: lui
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 2;
		
		ALUasel	= `x;
	   ALUbsel	= 1;
		ALUOp		= 4'b1100;
	
		 	    		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
		
		Tnew		= 1;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b001001: begin: addiu
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
		
		Tnew		= 1;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	6'b001000: begin: addi
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		 	    		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
		
		Tnew		= 1;
		Tuse_Rs	= 1;
		Tuse_Rt	= 3;
	end
	
	
	6'b000100: begin: beq
		NPCsel	= 1;
		NPCOp		= 0;
		CMPOp		= 0;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		 	    		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= `x;
		
		Tnew		= 0;
		Tuse_Rs	= 0;
		Tuse_Rt	= 0;
	end
	
	6'b000111: begin: bgtz
		NPCsel	= 1;
		NPCOp		= 0;
		CMPOp		= 2;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		 	    		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
		
		Tnew		= 0;
		Tuse_Rs	= 0;
		Tuse_Rt	= 0;
	end
	
	6'b000110: begin: blez
		NPCsel	= 1;
		NPCOp		= 0;
		CMPOp		= 3;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		 	    		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
		
		Tnew		= 0;
		Tuse_Rs	= 0;
		Tuse_Rt	= 0;
	end
	
	6'b000101: begin: bne
		NPCsel	= 1;
		NPCOp		= 0;
		CMPOp		= 5;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		 	    		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
		
		Tnew		= 0;
		Tuse_Rs	= 0;
		Tuse_Rt	= 0;
	end
	
	6'b000010: begin: j
		NPCsel	= 1;
		NPCOp		= 1;
		CMPOp		= `x;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		 	    		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= `x;
		
		Tnew		= 0;
		Tuse_Rs	= 3;
		Tuse_Rt	= 3;
	end
	
	6'b000011: begin: jal
		NPCsel	= 1;
		NPCOp		= 1;
		CMPOp		= `x;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= 2;
		ALUOp		= 4'b1100;
	
		 	    		 		
		A3sel		= 3;
		WDsel		= 0;
		GRF_WE	= 1;
		
		Tnew		= 0;
		Tuse_Rs	= 3;
		Tuse_Rt	= 3;
	end
	
	default: begin
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= 4'bxxxx;
	
		 	    		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
		
		Tnew		= 0;
		Tuse_Rs	= 3;
		Tuse_Rt	= 3;
	end
endcase
end

endmodule

