module ProgramCounter16Bit(pc,nextaddress,clk,rst);
input [15:0]pc;
input clk,rst;
output reg [15:0] nextaddress;
always@(posedge clk)
begin
if(rst)
	nextaddress = 16'h0000;
else
	nextaddress = pc;
end
endmodule