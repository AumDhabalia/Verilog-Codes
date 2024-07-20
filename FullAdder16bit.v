module FullAdder16bit(A,B,Cin,Sum,Carry);
input [15:0] A;
input [15:0] B;
input Cin;
output [15:0] Sum;
output Carry;
wire[14:0] c;

fa fa1(Cin,A[0],B[0],Sum[0],c[0]);
fa fa2(c[0],A[1],B[1],Sum[1],c[1]);
fa fa3(c[1],A[2],B[2],Sum[2],c[2]);
fa fa4(c[2],A[3],B[3],Sum[3],c[3]);
fa fa5(c[3],A[4],B[4],Sum[4],c[4]);
fa fa6(c[4],A[5],B[5],Sum[5],c[5]);
fa fa7(c[5],A[6],B[6],Sum[6],c[6]);
fa fa8(c[6],A[7],B[7],Sum[7],c[7]);
fa fa9(c[7],A[8],B[8],Sum[8],c[8]);
fa fa10(c[8],A[9],B[9],Sum[9],c[9]);
fa fa11(c[9],A[10],B[10],Sum[10],c[10]);
fa fa12(c[10],A[11],B[11],Sum[11],c[11]);
fa fa13(c[11],A[12],B[12],Sum[12],c[12]);
fa fa14(c[12],A[13],B[13],Sum[13],c[13]);
fa fa15(c[13],A[14],B[14],Sum[14],c[14]);
fa fa16(c[14],A[15],B[15],Sum[15],Carry);
endmodule
/////////////////////////////////////////
module fa(cin,a,b,s,cout);
input a,b,cin;
output s,cout;
assign s = a^b^cin;
assign cout = ((a|cin)&b)|(cin&a);
endmodule