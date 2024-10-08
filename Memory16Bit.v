module Memory16Bit(rdata,wdata,addr,datain,dataout,clk);
input [15:0] datain,addr;
input rdata,wdata,clk;
output reg [15:0]dataout;
reg [15:0]memoryfile[0:255];
always@(posedge clk)
begin
if(rdata)
	dataout = memoryfile[addr];
if(wdata)
	memoryfile[addr] = datain;
end
endmodule