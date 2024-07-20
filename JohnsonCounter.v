module JohnsonCounter(out,rst,clk);
input clk,rst;
output [3:0]out;
reg [3:0]q;
always@(*)
if(rst)
begin 
 	q <= 4'b0001;
end
else
begin
	q <= {q[2:0],~q[3]};
end
assign out[0]=q[0];
assign out[1]=q[1];
assign out[2]=q[2];
assign out[3]=q[3];  
endmodule