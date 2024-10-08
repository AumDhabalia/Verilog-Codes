/*Control Unit acts as brain of the datapath. When opcode and functional class are fed,
control unit initializes those blocks required for the instruction.
*/
module ControlUnit32Bit(op,fn,regwt,regdst,alusrc,
						 addsub,rdata,wdata,reginsrc,
						 brtype,pcsrc,fnc,lgc);
input [5:0]op,fn;
reg [16:0] signal;
output regwt,alusrc,addsub,rdata,wdata;
output [1:0]regdst,reginsrc,brtype,pcsrc,fnc,lgc;
always@(*)
begin
case(op)
	6'b000000:begin
				 case(fn)
					6'b100000:signal = 17'b10101000010000000;//ADD
					6'b100010:signal = 17'b10101010010000000;//SUB
					6'b101010:signal = 17'b10101010001000000;//Set Less Than
					6'b100100:signal = 17'b10101000011000000;//AND
					6'b100101:signal = 17'b10101000111000000;//OR
					6'b100110:signal = 17'b10101001011000000;//XOR
					6'b100111:signal = 17'b10101001111000000;//NOR
					6'b001000:signal = 17'b00000000000000010;//Jump Register
					6'b001100:signal = 17'b00000000000000011;//System Call
					default:signal = 17'bxxxxxxxxxxxxxxxxx;
					endcase
				 end
	6'b001000:signal = 17'b10001100010000000;//ADDi
	6'b001010:signal = 17'b10001110001000000;//Set Less Than i
	6'b001100:signal = 17'b10001100011000000;//ANDi
	6'b001101:signal = 17'b10001100111000000;//ORi
	6'b001110:signal = 17'b10001101011000000;//XORi
	6'b100011:signal = 17'b10000100010100000;//LW
	6'b101011:signal = 17'b00000100010010000;//SW
	6'b000010:signal = 17'b00000000000000001;//Jump
	6'b000001:signal = 17'b00000000000001100;//BLTZ
	6'b000100:signal = 17'b00000000000000100;//BEQ
	6'b000101:signal = 17'b00000000000001000;//BNE
	6'b001111:signal = 17'b10001100000000000;//LUi
	6'b000011:signal = 17'b11010000000000001;//Jump & Link
	default:signal = 17'bxxxxxxxxxxxxxxxxx;
endcase
end
assign regwt = signal[16];
assign regdst = {signal[15],signal[14]};
assign {reginsrc,alusrc} = {signal[13:12],signal[11]};
assign {addsub,lgc} = {signal[10],signal[9:8]};
assign {fnc,rdata} = {signal[7:6],signal[5]};
assign {wdata,brtype,pcsrc} = {signal[4],signal[3:2],signal[1:0]};
endmodule