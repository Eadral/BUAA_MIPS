`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:04:18 11/15/2018 
// Design Name: 
// Module Name:    IFU 
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
module pseudo_im #(parameter SIZE=4096)(
    input [31:0] PC,
    output [31:0] Instr
    );

wire [31:0] imA = PC - 'h3000;

reg [31:0] im [0:SIZE-1];
assign Instr = im[imA[13:2]];

integer i;
initial begin
	for (i = 0; i < 4096; i=i+1)
		im[i] = 0;
	$readmemh("code.txt", im);
	$readmemh("code_handler.txt",im,1120,2047);
end

endmodule
