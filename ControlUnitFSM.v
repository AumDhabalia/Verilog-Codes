module ControlUnitFSM(clk,opc,fnc,PCWrite,InstData,MemRead,MemWrite,IRWrite,RegDst,RegInSrc,
							 RegWrite,ALUSrcX,ALUSrcY,ALUFunc,JumpAddr,PCSrc,ALUZero,ALUOvfl);
input [5:0] opc;
input [5:0] fnc;
input clk;
output reg PCWrite,InstData,ALUZero,ALUOvfl,JumpAddr,MemRead,MemWrite,IRWrite,RegInSrc,RegWrite,ALUSrcX;
output reg [1:0] RegDst,ALUSrcY,PCSrc;
output reg [5:0] ALUFunc;
reg [3:0] crntst = 4'b0000;
parameter state_0 = 4'b0000,
state_1 = 4'b0001,
state_2 = 4'b0010,
state_3 = 4'b0011,
state_4 = 4'b0100,
state_5 = 4'b0101,
state_6 = 4'b0110,
state_7 = 4'b0111,
state_8 = 4'b1000;
always @(posedge clk)
begin
	case(crntst)
		state_0:begin
					{InstData,MemRead,IRWrite} <= 3'b011;
					{ALUSrcX,ALUSrcY} <= 3'b000;
					ALUFunc <= 6'b100000;
					{PCSrc,PCWrite} <= 3'b111;
					crntst <= 4'b0001;
				  end
		state_1:begin
					{ALUSrcX,ALUSrcY} <= 3'b011;
					ALUFunc <= 6'b100000;
					crntst <= (opc == 6'b100011|opc == 6'b101011)?(4'b0010):
					((opc == 6'b000000 & fnc == 6'b001000)
					|(opc == 6'b000000 & fnc == 6'b001100)|opc == 6'b000010|opc == 6'b000001|opc == 6'b000100|opc == 6'b000101|opc == 6'b000011)
					?(4'b0101):(4'b0111);
				  end
		state_2:begin
					{ALUSrcX,ALUSrcY} <= 3'b110;
					ALUFunc <= 6'b100000;
					crntst <= (opc == 6'b100011)?(4'b0011):(opc == 6'b101011)?(4'b0110):(4'b0000);
				  end
		state_5:begin
					JumpAddr <= (opc == 6'b000010 | opc == 6'b000011)?(1'b0):(opc == 6'b000000)?(1'b1):(1'bx);
					PCSrc <= ((opc == 6'b000000 & fnc == 6'b001100)|opc == 6'b000010|opc == 6'b000011)?(2'b00):
								(opc == 6'b000000 & fnc == 6'b001000)?(2'b01):(opc == 6'b000001|opc == 6'b000100 | opc == 6'b000101)?(2'b10):(2'bxx);
					PCWrite <= ((opc == 6'b000000 & fnc == 6'b001000)|
									(opc == 6'b000000 & fnc == 6'b001100)|opc == 6'b000010|opc == 6'b000011)?(1'b1):(1'b0);
					{ALUSrcX,ALUSrcY} <= 3'b101;
					ALUFunc <= 6'b100010;
					crntst <= 4'b0000;
				  end
		state_7:begin
					ALUSrcY <= (opc == 6'b000000)?(2'b01):(2'b10);
					ALUSrcX <= 1'b1;
					ALUFunc <= fnc;
					crntst <= 4'b1000;
				  end
		state_3:begin
					{InstData,MemRead} <= 2'b11;
					crntst <= 4'b0100;
				  end
		state_6:begin
					{InstData,MemWrite} <= 2'b11;
					crntst <= 4'b0000;
				  end
		state_8:begin
					RegDst <= (opc == 6'b000000)?(2'b00):(2'b01);
					{RegInSrc,RegWrite} <= 2'b11;
					crntst <= 4'b0000;
				  end
		state_4:begin
					{RegDst,RegInSrc,RegWrite} <= 4'b0001;
					crntst <= 4'b0000;
				  end
	endcase
end
endmodule