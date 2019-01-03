`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:55:00 11/15/2018 
// Design Name: 
// Module Name:    DM 
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
module pseudo_dm #(parameter SIZE=4096)(
    input [31:0] A,
    input [31:0] WD,
    output [31:0] RD,
    input RE,
    input WE,
	 //input [3:0] BE,
    input clk,
    input Reset,
	 input [31:0] PC
    );

reg [31:0] dm [0:SIZE-1];

integer i;

always @(posedge clk) begin
	if (Reset) begin
		for (i = 0; i < SIZE; i = i + 1)
			dm[i] <= 0;
	end else if (WE) begin
		$display("%d@%h: *%h <= %h", $time, PC, A >> 2 << 2, WD);
		//if (BE[3] == 1) dm[A[13:2]][31:24] = WD[31:24];
		//if (BE[2] == 1) dm[A[13:2]][23:16] = WD[23:16];
		//if (BE[1] == 1) dm[A[13:2]][15:8] = WD[15:8];
		//if (BE[0] == 1) dm[A[13:2]][7:0] = WD[7:0];
		dm[A[13:2]] <= WD;
	end
end

//assign RD = RE ? dm[A[13:2]] : 32'bx;
assign RD = dm[A[13:2]];

endmodule


//
module dmInput(
		input [1:0] A,
		input [2:0] DMIOp,
		input [31:0] WD,
		input [31:0] DM_Out,
		output reg [31:0] DMIn
		);

wire [31:0] MUX_SB_Out;
mux4 MUX_SB(.out(MUX_SB_Out), .s(A[1:0]),
				.d0({DM_Out[31:8], WD[7:0]}), .d1({DM_Out[31:16], WD[7:0], DM_Out[7:0]}),
				.d2({DM_Out[31:24], WD[7:0], DM_Out[15:0]}), .d3({WD[7:0], DM_Out[23:0]}) );

wire [31:0] MUX_SH_Out;
mux2 MUX_SH(.out(MUX_SH_Out), .s(A[1]),
				.d0( {DM_Out[31:16], WD[15:0]} ),
				.d1( {WD[15:0], DM_Out[15:0]} )
				);

always @(*) begin
case (DMIOp)
	0: DMIn = WD;
	1: DMIn = MUX_SB_Out;
	2: DMIn = MUX_SH_Out;
	default: DMIn = WD;
endcase
end						  

		
endmodule



//
module dmOutput(
		input [1:0] A,
		input [2:0] DMOOp,
		input [31:0] RD,
		output reg [31:0] DMOut
		);

wire [31:0] MUX_LB_Out;
mux4 MUX_LB(.out(MUX_LB_Out), .s(A[1:0]),
			   .d0({{24{RD[7]}}, RD[7:0]}),
			   .d1({{24{RD[15]}}, RD[15:8]}),
			   .d2({{24{RD[23]}}, RD[23:16]}),
			   .d3({{24{RD[31]}}, RD[31:24]})
				);

wire [31:0] MUX_LBU_Out;
mux4 MUX_LBU(.out(MUX_LBU_Out), .s(A[1:0]),
			   .d0({{24{1'b0}}, RD[7:0]}),
			   .d1({{24{1'b0}}, RD[15:8]}),
			   .d2({{24{1'b0}}, RD[23:16]}),
			   .d3({{24{1'b0}}, RD[31:24]})
				);

wire [31:0] MUX_LH_Out;
mux2 MUX_LH(.out(MUX_LH_Out), .s(A[1]),
				.d0( {{16{RD[15]}}, RD[15:0]} ),
				.d1( {{16{RD[31]}}, RD[31:16]} )
				);

wire [31:0] MUX_LHU_Out;
mux2 MUX_LHU(.out(MUX_LHU_Out), .s(A[1]),
				.d0( {{16{1'b0}}, RD[15:0]} ),
				.d1( {{16{1'b0}}, RD[31:16]} )
				);
				
always @(*)
case (DMOOp)
	0: DMOut = RD;
	1: DMOut = MUX_LBU_Out;
	2: DMOut = MUX_LB_Out;
	3: DMOut = MUX_LHU_Out;
	4: DMOut = MUX_LH_Out;
	default: DMOut = RD;
endcase
		
endmodule


