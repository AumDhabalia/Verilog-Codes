module RegisterBank32Bit(wt,raddr0,raddr1,addrwt,A,B,C,clk);
input [4:0]raddr0,raddr1,addrwt;
input clk;
input [31:0] C;
output reg [31:0] A,B;
input wt;
reg [31:0]regFile[0:31];
always@(posedge clk)
begin
	A <= regFile[raddr0];//Input 1
	B <= regFile[raddr1];///Input 2
	regFile[addrwt] <= C&{32{wt}};///Output
end
endmodule