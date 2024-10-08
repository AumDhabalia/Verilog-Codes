module CacheMemory16Bit(pc,inst);
input [15:0]pc;
output reg [15:0]inst;
reg [15:0]instmem[0:15];
initial
begin
	instmem[0] = 16'h500A;//ADDi
	instmem[1] = 16'h50BC;//ADDi
	instmem[2] = 16'h0008;//ADD
	instmem[3] = 16'h5119;//ADDi
	instmem[4] = 16'h0810;//SUB
	instmem[5] = 16'hA009;//Jump
	instmem[6] = 16'hC000;//XOR
	instmem[7] = 16'hB500;//NOR
	instmem[8] = 16'hFF00;//ADDi
	instmem[9] = 16'h1808;//OR
	instmem[10] = 16'h00F0;//ANDi
end
always@(pc)
begin
	inst <= instmem[pc];
end
endmodule