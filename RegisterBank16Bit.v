module RegisterBank16Bit(wt,raddr0,raddr1,A,B,C,clk);
input [3:0]raddr0,raddr1;
input [15:0] C;
input clk;
output reg [15:0] A,B;
input wt;
reg [15:0]regFile[0:15];
always@(posedge clk)
begin
	A <= regFile[raddr0];//Input 1
	B <= regFile[raddr1];///Input 2
	regFile[raddr1] <= {16{wt}}&C;///Output
end
endmodule