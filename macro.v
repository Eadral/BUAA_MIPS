`define Op 31:26
`define Rs 25:21
`define Rt 20:16
`define Rd 15:11
`define Shamt 10:6
`define Func 5:0

`define Imm 15:0
`define Addr 25:0

`define x 32'b0

// macro
`define R 6'b000000

// normal
`define nop		32'b0
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

`define beql	6'b010100

`define special2	6'b011100

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

`define add		6'b100000
`define sub		6'b100010
`define addi	6'b001000

// Rs
`define madd	6'b000000
`define maddu	6'b000001
`define mul 	6'b000010

// Rt
`define bgez	5'b00001
`define bltz	5'b00000

// CP0
`define COP0	6'b010000
`define eret 32'b010000_1000_0000_0000_0000_0000_011000
`define mtc0	5'b00100

// ExcCode
`define Int 0
`define AdEL 4
`define AdES 5
`define RI 10
`define Ov 12

`define SR 12
`define CAUSE 13
`define EPC 14
`define PrID 15

// SR
`define IM 15:10	// interruption mask
`define EXL 1		// 1: not allow interruption in exception
`define IE 0		// global interruption enable

// CAUSE
`define IP 15:10	// interruption
`define ExcCode 6:2	// type
`define BD 31
