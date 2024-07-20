/*The following design is purely made of combinational logic.
The ALU has 3 blocks along with 3 flags namely add/sub, shifter & logical blocks
and carry, zero & overflow flags.
Output of addsub = a....functionclass = 00
Output of slt = b.......functionclass = 01
Output of shift = c.....functionclass = 10
Output of logical = d...functionclass = 11

For addsub, carry look ahead adder is used with 2's complement block.
For shift, a barrel shifter is used with logic left-right and arithmetic right. Default shift is always set to shift right
	Shift Logic Right.........00
	Shift Logic Left..........01
	Shift Arithimetic Right...10
	
Logic block : 	AND...00
					OR....01
					XOR...10
					NOR...11
*/
module ALU16Bit(addsub,lgc,s,fn,A,B,out,cflag,zflag,ovflag);
input [1:0]fn,lgc,s;
input addsub;
input [15:0]A,B;
wire [15:0]a,b,c,d;
wire Cout;
output [15:0]out;
output cflag,zflag,ovflag;

/////////////////

FALAC16Bit fa(A,B,addsub,a,Cout);//a = sum...
Shifter16Bit sr(A,B[3:0],s[0],s[1],c);//c = Shift
lg lg0(lgc,A,B,d);//d = logic
assign b = a[15];//b = Slt
//00...Sum 01...SLT 10...Shift 11...logic
assign out = fn[1]?(fn[0]?d:c):(fn[0]?b:a);
assign cflag = Cout;
assign zflag = a?1'b0:1'b0;
assign ovflag = (a>16'h0000)?1'b1:1'b0;
endmodule

//////////////////

module lg(lgc,A,B,out);
input [1:0]lgc;
input [15:0] A,B;
output [15:0]out;
assign out = lgc[1]?(lgc[0]?~(A|B):(A^B)):(lgc[0]?(A|B):(A&B));
endmodule

////////////////

module FALAC16Bit(A,B,en,Sum,Cout);
input [15:0] A,B;
input en;
wire [15:0]Bi;
output [15:0] Sum;
output Cout;
wire [15:0] G,P,c;
assign Bi = B^{16{en}};
assign G = A&Bi;
assign P = A^Bi;
assign c[0] = G[0]|(P[0]&en);
assign Sum [0] = P[0]^en;
generate
	genvar i;
		for(i=1;i<16;i=i+1)
		begin:FALAC16Bit
			assign c[i] = G[i]|(P[i]&c[i-1]);
			assign Sum[i] = P[i]^c[i-1];
		end
endgenerate
assign Cout = c[15];
endmodule
//////////////////
module Shifter16Bit(A,B,en,s,out);//Default Shift right...
input [15:0]A;
input [3:0]B;
input en,s;//00...SLR,01...SLL,10...SAR
wire [3:0]Bi;
assign Bi = (B^{4{en}})+{3'b000,en};
reg [15:0]C;
output [15:0]out;
always@(*)
begin
	case(Bi)
		4'b0001:	C = s?({A[15],A[15:1]}):({A[0],A[15:1]}&((en)?16'h8000:16'h7FFF));
		4'b0010: C = s?({{2{A[15]}},A[15:2]}):({A[1:0],A[15:2]}&((en)?16'hB000:16'h3FFF));
		4'b0011: C = s?({{3{A[15]}},A[15:3]}):({A[2:0],A[15:3]}&((en)?16'hE000:16'h1FFF));
		4'b0100: C = s?({{4{A[15]}},A[15:4]}):({A[3:0],A[15:4]}&((en)?16'hF000:16'h0FFF));
		4'b0101: C = s?({{5{A[15]}},A[15:5]}):({A[4:0],A[15:5]}&((en)?16'hF800:16'h07FF));
		4'b0110: C = s?({{6{A[15]}},A[15:6]}):({A[5:0],A[15:6]}&((en)?16'hFB00:16'h03FF));
		4'b0111: C = s?({{7{A[15]}},A[15:7]}):({A[6:0],A[15:7]}&((en)?16'hFE00:16'h01FF));
		4'b1000: C = s?({{8{A[15]}},A[15:8]}):({A[7:0],A[15:8]}&((en)?16'hFF00:16'h00FF));
		4'b1001: C = s?({{9{A[15]}},A[15:9]}):({A[8:0],A[15:9]}&((en)?16'hFF80:16'h007F));
		4'b1010: C = s?({{10{A[15]}},A[15:10]}):({A[9:0],A[15:10]}&((en)?16'hFFB0:16'h003F));
		4'b1011: C = s?({{11{A[15]}},A[15:11]}):({A[10:0],A[15:11]}&((en)?16'hFFE0:16'h001F));
		4'b1100: C = s?({{12{A[15]}},A[15:12]}):({A[11:0],A[15:12]}&((en)?16'hFFF0:16'h000F));
		4'b1101: C = s?({{13{A[15]}},A[15:13]}):({A[12:0],A[15:13]}&((en)?16'hFFF8:16'h0007));
		4'b1110: C = s?({{14{A[15]}},A[15:14]}):({A[13:0],A[15:14]}&((en)?16'hFFFB:16'h0003));
		4'b1111: C = s?({16{A[15]}}):({A[14:0],A[15]}&((en)?16'hFFFE:16'h0001));
		default: C = {A[15:0]};
	endcase
end
assign out = C;
endmodule