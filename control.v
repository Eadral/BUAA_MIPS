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

module control(
	 input [31:0] IR,
	 
	 output reg [1:0] NPCsel,
	 output reg [1:0] NPCOp,
	 output reg [1:0] CMPOp,
	 output reg [1:0] ExtOp,

	 
	 output reg [1:0] ALUasel,
	 output reg [1:0] ALUbsel,
	 output reg [3:0] ALUOp,
	 
	 output reg DM_RE,
	 output reg DM_WE,
	 
	 output reg [1:0] A3sel,
	 output reg [1:0] WDsel,
	 output reg GRF_WE
    );

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

