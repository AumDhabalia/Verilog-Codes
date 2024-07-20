module FALAC16Bit(A,B,Sum,Cin,Cout);
input [15:0] A,B;
input Cin;
output [15:0] Sum;
output Cout;
wire [15:0] G,P,c;
assign G = A&B;
assign P = A^B;
assign c[0] = G[0]|(P[0]&Cin);
generate
	genvar i;
		for(i=1;i<16;i=i+1)
		begin:FALAC16Bit
			assign c[i] = G[i]|(P[i]&c[i-1]);
		end
endgenerate
assign Sum = A^B^c;
assign Cout = c[15];
endmodule