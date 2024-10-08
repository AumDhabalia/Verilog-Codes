/*This program contains a design of basic RAM of size 4x4 bits meaning
2 byte size RAM.
The RAM is designed in a matrix form such that rows are address lines and each row contains
2^n bits. So, the size of RAM is m * 2^n bits.
*/
module RAM4x4(In,addr,rw,en,out,clk);
input [3:0]In;
input [1:0]addr;
input rw,en,clk;
reg [3:0]mem[0:3];
output reg [3:0]out;
always@(posedge clk)
begin
if(en==1)
begin
	if(rw==1)
		mem[addr]=In;
	else
		out=mem[addr];
	end
else
out = 4'bz;
end
endmodule