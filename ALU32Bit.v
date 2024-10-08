/*This block is a 32 bit Arithimetic Logic Unit which performs addition, subtraction
shifting and logical AND,OR,NOR,XOR along with two flags namely zero and carry.
Carry Look Ahead Adder is used with piggyback connection of 2's complement.
FunctionClass = Add/Sub...00
					 SLT.......10
					 Logic.....11

Add/Sub....0/1
Logic = AND...00
		  OR....01
		  XOR...10
		  NOR...11
*/
module ALU32Bit(addsub,lgc,fn,A,B,out,zflag,ovflag);
input [1:0]fn,lgc;
input addsub;
input [31:0]A,B;
wire [31:0]a,b,d;
wire Cout;
output zflag,ovflag;
output [31:0]out;

FALAC16Bit fa(A,B,addsub,a,Cout);//a = sum...
//Shifter16Bit sr(A,B,s[0],s[1],c);//c = Shift
log lg(lgc,A,B,d);//d = logic
assign b = a[31];//Set Less Than
assign out = fn[1]?(fn[0]?d:a):(fn[0]?b:a);
assign zflag = (a)?1'b0:1'b1;
assign ovflag = (a>32'hFFFFFFFF)?1'b0:1'b1;
endmodule
//////////////////
module log(lgc,A,B,out);
input [1:0]lgc;
input [31:0] A,B;
output [31:0]out;
assign out = lgc[1]?(lgc[0]?~(A|B):(A^B)):(lgc[0]?(A|B):(A&B));
endmodule
////////////////
module FALAC16Bit(A,B,en,Sum,Cout);
input [31:0] A,B;
input en;
wire [31:0]Bi;
output [31:0] Sum;
output Cout;
wire [31:0] G,P,c;
assign Bi = B^{32{en}};
assign G = A&Bi;
assign P = A^Bi;
assign c[0] = G[0]|(P[0]&en);
assign Sum [0] = P[0]^en;
generate
	genvar i;
		for(i=1;i<32;i=i+1)
		begin:FALAC16Bit
			assign c[i] = G[i]|(P[i]&c[i-1]);
			assign Sum[i] = P[i]^c[i-1];
		end
endgenerate
assign Cout = c[31];
endmodule