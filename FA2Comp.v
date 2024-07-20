module FA2Comp(A,B,en,Sum,Carry);
input [3:0] A,B;
input en;
output [3:0] Sum;
output Carry;
wire [2:0] c;
wire [3:0] out;
assign out = B^{4{en}};

FA FA1(A[0],out[0],en,Sum[0],c[0]);
FA FA2(A[1],out[1],c[0],Sum[1],c[1]);
FA FA3(A[2],out[2],c[1],Sum[2],c[2]);
FA FA4(A[3],out[3],c[2],Sum[3],Carry);
endmodule
///////////////////////
module FA(a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
assign sum = a^b^cin;
assign cout = (a&b)|(b&cin)|(cin&a);
endmodule