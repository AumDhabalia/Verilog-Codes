module Memory32Bit(rdata,wdata,addr,datain,dataout,clk);
input [9:0]addr;
input clk;
input [31:0]datain;
output reg [31:0]dataout;
input rdata,wdata;
reg [31:0]memory[0:511];
always@(posedge clk)
begin
	dataout <= {32{rdata}}&memory[addr];//LW
	memory[addr] <= {32{wdata}}&datain;//SW
end
endmodule