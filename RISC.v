module RISC(zflag,cflag,ovflag,rst,clk);
input rst,clk;
wire regwt,alusrc,addsub,rdata,wdata;
wire [15:0]A,B,out,C,dataout,aluin,inst,nextaddr,pc;
wire [1:0]brtype,pcsrc,fnc,lgc,shift,reginsrc,regdst;
output zflag,cflag,ovflag;

ProgramCounter16Bit progcntr(nextaddr,pc,clk,rst);
////////////
AddressGenerator16Bit addr(pc,A,pcsrc,brtype,inst[10:0],nextaddr);
////////////
CacheMemory16Bit line(pc,inst);
////////////
ControlUnit16Bit ctrl(inst[15:11],regwt,regdst,alusrc,addsub,rdata,wdata,
							 reginsrc,brtype,pcsrc,fnc,lgc,shift);
////////////
RegisterBank16Bit regfile(regwt,inst[10:7],inst[6:3],A,B,C);
////////////
assign aluin = (alusrc)?{{9{inst[6]}},inst[6:0]}:B;
////////////
ALU16Bit alu(addsub,lgc,shift,fnc,A,aluin,out,cflag,zflag,ovflag);
////////////
assign C = (reginsrc)?dataout:out;
////////////
Memory16Bit memory(rdata,wdata,out,B,dataout,clk);
////////////
endmodule