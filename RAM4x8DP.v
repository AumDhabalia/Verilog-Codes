module RAM4x8DP(clk,addrA,addrB,A,B,en,outA,outB);
input clk;
input [1:0] addrA,addrB;
input [7:0] A,B;
input [1:0]en;
output reg [7:0] outA,outB;
reg [7:0]mem[3:0];

always@(posedge clk)
begin
	if(en[0])
		mem[addrA] <= A;
	else
		outA <= mem[addrA];
	if(en[1])
		mem[addrB] <= B;
	else
		outB <= mem[addrB];
end
endmodule
