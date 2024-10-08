module ProgramCounter32Bit(nextaddr,pc,clk,rst);
input [31:0] nextaddr;
input clk,rst;
output reg [31:0]pc;
always@(posedge clk)
begin
	pc = nextaddr&{32{~rst}};
end
endmodule