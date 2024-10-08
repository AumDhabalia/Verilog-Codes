module ControlUnit16Bit(op,regwt,regdst,alusrc,
						 addsub,rdata,wdata,reginsrc,
						 brtype,pcsrc,fnc,lgc,shift);
input [4:0]op;
reg [18:0] signal;
output regwt,alusrc,addsub,rdata,wdata;
output [1:0]regdst,reginsrc,brtype,pcsrc,fnc,lgc,shift;
always@(*)
begin
case(op)
	5'b00000:signal = 19'b1010100000000000000;//ADD
	5'b00001:signal = 19'b1010101000000000000;//SUB
	5'b00010:signal = 19'b1010100001100000000;//AND
	5'b00011:signal = 19'b1010100011100000000;//OR
	5'b00100:signal = 19'b1010100101100000000;//XOR
	5'b00101:signal = 19'b1010100111100000000;//NOR
	5'b00110:signal = 19'b1010101000100000000;//SLT
	5'b00111:signal = 19'b1010100001000000001;//SLL
	5'b01000:signal = 19'b1010100001000000000;//SLR
	5'b01001:signal = 19'b1010100001000000010;//SAR
	5'b01010:signal = 19'b1000110000000000000;//ADDi
	5'b01011:signal = 19'b1000111000000000000;//Subi
	5'b01100:signal = 19'b1000110001100000000;//ANDi
	5'b01101:signal = 19'b1000110011100000000;//ORi
	5'b01110:signal = 19'b1000110101100000000;//XORi
	5'b01111:signal = 19'b1000110111100000000;//NORi
	5'b10000:signal = 19'b1000111000100000000;//SLTi
	5'b10001:signal = 19'b1000110001000000001;//SLLi
	5'b10010:signal = 19'b1000110001000000000;//SLRi
	5'b10011:signal = 19'b1000110001000000010;//SARi
	5'b10100:signal = 19'b0000000000000000100;//Jump
	5'b10101:signal = 19'b0000000000000001000;//JR
	5'b10110:signal = 19'b0000000000000000100;//JAl
	5'b10111:signal = 19'b0000000000000110000;//BLTZ
	5'b11000:signal = 19'b0000000000000010000;//BZ
	5'b11001:signal = 19'b0000000000000100000;//BGTZ
	5'b11010:signal = 19'b1000110000010000000;//LW
	5'b11011:signal = 19'b0000010000001000000;//SW
	5'b11111:signal = 19'b0000000000000001100;//SysCall
	default:signal = 19'bxxxxxxxxxxxxxxxxxxx;
endcase
end
assign regwt = signal[18];
assign regdst = {signal[17],signal[16]};
assign {reginsrc,alusrc} = {signal[15:14],signal[13]};
assign {addsub,lgc} = {signal[12],signal[11:10]};
assign {fnc,rdata} = {signal[9:8],signal[7]};
assign {wdata,brtype,pcsrc} = {signal[6],signal[5:4],signal[3:2]};
assign shift = signal[1:0];
endmodule