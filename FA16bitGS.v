module FA16bitGS#(parameter N = 16)(A,B,Cin,Sum,Carry);
input [N-1:0] A;
input [N-1:0] B;
input Cin;
output [N-1:0] Sum;
output [N-1:0] Carry;
	fa h1(A[0],B[0],Cin,Carry[0],Sum[0]);
	generate
		genvar i;
		for(i=1;i<N;i=i+1)
			begin : FA16bitGS
				fa h1(A[i],B[i],Carry[i-1],Sum[i],Carry[i]);
			end
	endgenerate
endmodule
///////////////////////////////
module fa(a,b,cin,sum,cout);
input a,b,cin;
output cout,sum;
assign sum = a^b^cin;
assign cout = (a&b)|(b&cin)|(cin&a);
endmodule