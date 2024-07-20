module FullSubtractor16bit(A,B,Bin,D,Borrow);
input [15:0] A;
input [15:0] B;
input Bin;
output [15:0] D;
output Borrow;
wire[14:0] b;
t
fs fs1(Bin,A[0],B[0],D[0],b[0]);
fs fs2(b[0],A[1],B[1],D[1],b[1]);
fs fs3(b[1],A[2],B[2],D[2],b[2]);
fs fs4(b[2],A[3],B[3],D[3],b[3]);
fs fs5(b[3],A[4],B[4],D[4],b[4]);
fs fs6(b[4],A[5],B[5],D[5],b[5]);
fs fs7(b[5],A[6],B[6],D[6],b[6]);
fs fs8(b[6],A[7],B[7],D[7],b[7]);
fs fs9(b[7],A[8],B[8],D[8],b[8]);
fs fs10(b[8],A[9],B[9],D[9],b[9]);
fs fs11(b[9],A[10],B[10],D[10],b[10]);
fs fs12(b[10],A[11],B[11],D[11],b[11]);
fs fs13(b[11],A[12],B[12],D[12],b[12]);
fs fs14(b[12],A[13],B[13],D[13],b[13]);
fs fs15(b[13],A[14],B[14],D[14],b[14]);
fs fs16(b[14],A[15],B[15],D[15],Borrow);
endmodule
/////////////////////////////////////////
module fs(bin,a,b,s,bout);
input a,b,bin;
output s,bout;
assign s = a^b^bin;
assign bout = (~a&(b|bin))|(b&bin);
endmodule