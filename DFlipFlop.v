module DFlipFlop(d,clk,q);
input d,clk;
output [3:0] q;
wire [3:0] q1;

dff f1(d,clk,q1[0]);
dff f2(q1[0],clk,q1[1]);
dff f3(q1[1],clk,q1[2]);
dff f4(q1[2],clk,q1[3]);
assign q = q1;
endmodule
///////////////
module dff(a,clk,out);
input a,clk;
output reg out;
always@(posedge clk)
begin
	out <= a;
end
endmodule