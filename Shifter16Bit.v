module Shifter16Bit(A,B,en,s,out);//Default Shift right...
input [15:0]A;
input [3:0]B;
input en,s;
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