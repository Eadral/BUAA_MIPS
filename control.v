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

`define lw 	6'b100011
`define lb 	6'b100000
`define lbu 6'b100100
`define sw 	6'b101011
`define sb 	6'b101000
`define sh 	6'b101001
`define lh 	6'b100001
`define lhu	6'b100101

module control(
	 input [31:0] IR,
	 
	 output reg [1:0] NPCsel,
	 output reg [1:0] NPCOp,
	 output reg [3:0] CMPOp,
	 output reg [1:0] ExtOp,

	 
	 output reg [1:0] ALUasel,
	 output reg [1:0] ALUbsel,
	 output reg [3:0] ALUOp,
	 
	 output reg DM_RE,
	 output reg DM_WE,
	 output [2:0] DMOOp, DMIOp,
	 
	 output reg [1:0] A3sel,
	 output reg [1:0] WDsel,
	 output reg GRF_WE
    );

assign DMOOp = IR[`Op] == `lw ? 0 :
					IR[`Op] == `lb ? 2 :
					IR[`Op] == `lbu ? 1 :
					IR[`Op] == `sw ? 0 :
					IR[`Op] == `sb ? 0 :
					IR[`Op] == `lh ? 4 :
					IR[`Op] == `lhu ? 3 :
					`x ;
					

assign DMIOp = IR[`Op] == `lw ? 0 :
					IR[`Op] == `lb ? 0 :
					IR[`Op] == `lbu ? 0 :
					IR[`Op] == `sw ? 0 :
					IR[`Op] == `sb ? 1 :
					IR[`Op] == `sh ? 2 :
					`x;

always @(*) begin
case (IR[`Op])
	6'b000000: begin
		case (IR[`Func]) 
			6'b100001: begin: addu
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0000;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b100011: begin: subu
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0001;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b101010: begin: slt
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0111;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b101011: begin: sltu
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b1000;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b000000: begin: sll
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 2;
				ALUbsel	= 0;
				ALUOp		= 4'b0110;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b000011: begin: sra
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 2;
				ALUbsel	= 0;
				ALUOp		= 4'b0101;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b00010: begin: srl
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 2;
				ALUbsel	= 0;
				ALUOp		= 4'b0100;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b100100: begin: and_
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0010;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b100111: begin: nor_
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b1001;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b100101: begin: or_
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0011;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b100110: begin: xor_
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b1010;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b000100: begin: sllv
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0110;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b000111: begin: srav
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0101;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b000110: begin: srlv
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 0;
				ALUbsel	= 0;
				ALUOp		= 4'b0100;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b001001: begin: jalr
				NPCsel	= 2;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= 1;
				ALUbsel	= 2;
				ALUOp		= 4'b0000;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= 0;
				WDsel		= 0;
				GRF_WE	= 1;
			end
			
			6'b001000: begin: jr
				NPCsel	= 2;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
			end
			
			default: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= 4'bxxxx;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
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
			
				DM_RE		= `x;
				DM_WE		= `x;
				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= `x;
			end
			
			5'b00000: begin: bltz
				NPCsel	= 1;
				NPCOp		= 0;
				CMPOp		= 4;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= `x;
			
				DM_RE		= `x;
				DM_WE		= `x;
				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= `x;
			end
			
			default: begin
				NPCsel	= 0;
				NPCOp		= `x;
				CMPOp		= `x;
				ExtOp		= `x;
				
				ALUasel	= `x;
				ALUbsel	= `x;
				ALUOp		= 4'bxxxx;
			
				DM_RE		= 0;
				DM_WE		= 0;
				 				
				A3sel		= `x;
				WDsel		= `x;
				GRF_WE	= 0;
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
	
		DM_RE		= 0;
	   DM_WE		= 1;
		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
	end
	
	6'b101000: begin: sb
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 1;
	   DM_WE		= 1;
		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
	end
	
	6'b101001: begin: sh
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 1;
	   DM_WE		= 1;
		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
	end
	
	6'b100011: begin: lw
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 1;
	   DM_WE		= 0;
		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
	end
	
	6'b100000: begin: lb
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 1;
	   DM_WE		= 0;
		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
	end
	
	6'b100100: begin: lbu
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 1;
	   DM_WE		= 0;
		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
	end
	
	`lh: begin: lh
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 1;
	   DM_WE		= 0;
		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
	end
	
	`lhu: begin: lhu
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 1;
	   DM_WE		= 0;
		
		A3sel		= 1;
		WDsel		= 1;
		GRF_WE	= 1;
	end
	6'b001010: begin: slti
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0111;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
	end
	
	6'b001011: begin: sltiu
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b1000;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
	end
	
	6'b001100: begin: andi
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0010;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
	end
	
	6'b001101: begin: ori
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0011;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
	end
	
	6'b001110: begin: xori
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 1;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b1010;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
	end
	
	6'b001111: begin: lui
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 2;
		
		ALUasel	= 1;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
	end
	
	6'b001001: begin: addiu
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
	end
	
	6'b001000: begin: addi    // no exception!
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= 0;
		
		ALUasel	= 0;
	   ALUbsel	= 1;
		ALUOp		= 4'b0000;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= 1;
		WDsel		= 0;
		GRF_WE	= 1;
	end
	
	
	6'b000100: begin: beq
		NPCsel	= 1;
		NPCOp		= 0;
		CMPOp		= 0;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		DM_RE		= `x;
	   DM_WE		= `x;
		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= `x;
	end
	
	6'b000111: begin: bgtz
		NPCsel	= 1;
		NPCOp		= 0;
		CMPOp		= 2;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
	end
	
	6'b000110: begin: blez
		NPCsel	= 1;
		NPCOp		= 0;
		CMPOp		= 3;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
	end
	
	6'b000101: begin: bne
		NPCsel	= 1;
		NPCOp		= 0;
		CMPOp		= 5;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
	end
	
	6'b000010: begin: j
		NPCsel	= 1;
		NPCOp		= 1;
		CMPOp		= `x;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= `x;
	
		DM_RE		= `x;
	   DM_WE		= `x;
		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= `x;
	end
	
	6'b000011: begin: jal
		NPCsel	= 1;
		NPCOp		= 1;
		CMPOp		= `x;
		ExtOp		= `x;
		
		ALUasel	= 1;
	   ALUbsel	= 2;
		ALUOp		= 4'b0000;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= 3;
		WDsel		= 0;
		GRF_WE	= 1;
	end
	
	default: begin
		NPCsel	= 0;
		NPCOp		= `x;
		CMPOp		= `x;
		ExtOp		= `x;
		
		ALUasel	= `x;
	   ALUbsel	= `x;
		ALUOp		= 4'bxxxx;
	
		DM_RE		= 0;
	   DM_WE		= 0;
		 		
		A3sel		= `x;
		WDsel		= `x;
		GRF_WE	= 0;
	end
endcase
end

endmodule

