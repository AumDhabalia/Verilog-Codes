module Cache32Bit(pc,inst);
output reg [31:0] inst;
reg [7:0]cache[0:35];
input [31:0]pc;
initial
begin
	cache[0] <= 8'b00000011;//LUi...r25 = r14 + r7
	cache[1] <= 8'b00101110;
	cache[2] <= 8'b00111000;
	cache[3] <= 8'b00100000;
	cache[4] <= 8'b00100000;//ADDi
	cache[5] <= 8'b00100000;
	cache[6] <= 8'b00100000;
	cache[7] <= 8'b00100000;
	cache[8] <= 8'b00100000;//SUB
	cache[9] <= 8'b00100000;
	cache[10] <= 8'b00100000;
	cache[11] <= 8'b00100000;
	cache[12] <= 8'b00100000;//SUBi
	cache[13] <= 8'b00100000;
	cache[14] <= 8'b00100000;
	cache[15] <= 8'b00100000;
	cache[16] <= 8'b00100000;//SLL
	cache[17] <= 8'b00100000;
	cache[18] <= 8'b00100000;
	cache[19] <= 8'b00100000;
	cache[20] <= 8'b00100000;//SLR
	cache[21] <= 8'b00100000;
	cache[22] <= 8'b00100000;
	cache[23] <= 8'b00100000;
	cache[24] <= 8'b00100000;//SAR
	cache[25] <= 8'b00100000;
	cache[26] <= 8'b00100000;
	cache[27] <= 8'b00100000;
	cache[28] <= 8'b00100000;//LW
	cache[29] <= 8'b00100000;
	cache[30] <= 8'b00100000;
	cache[31] <= 8'b00100000;
	cache[32] <= 8'b00100000;//SW
	cache[33] <= 8'b00100000;
	cache[34] <= 8'b00100000;
	cache[35] <= 8'b00100000;
end
always@(*)
begin
	inst <= {cache[pc],cache[pc + 1],cache[pc + 2],cache[pc + 3]};
end
endmodule