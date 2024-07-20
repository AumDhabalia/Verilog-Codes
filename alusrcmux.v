module alusrcmux(A,imm,aluinsrc,aluin);
input [31:0] A;
input [15:0] imm;
input aluinsrc;
output [31:0] aluin;

assign aluin = (aluinsrc)?{{16{imm[15]}},imm}:A;
endmodule