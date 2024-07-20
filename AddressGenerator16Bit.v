/* This block generates next possible address. The address is generated based on
jump or branchtype instructions. Current address is fed from program-counter to this block.
pc = Program Counter Address
A = Value from register
pcsrc = Mode for selecting next type address
			pcincr/BrType...00
			jump............01
			jumpreturn......10
			SysCall.........11
Brtype = branch type instructions
			PCincr...00
			BZ.......01
			BGTZ.....10
			BLTZ.....11
*/
module AddressGenerator16Bit(pc,A,pcsrc,brtype,jump,nextaddr);
input [1:0]pcsrc,brtype;
input [10:0]jump;
input [15:0]A,pc;
output [15:0]nextaddr;
wire en;
Branch br(brtype,A,en);
PCsrc pcaddr(pc,pcsrc,A[15:0],jump,en,nextaddr);
endmodule

////////////////////

module Branch(brtype,A,en);
input [15:0]A;
input [1:0]brtype;
output en;
//00...PCincr 01...BZ 10...BGTZ 11...BLTZ
assign en = brtype[1]?(brtype[0]?((A[15])?1'b1:1'b0):((A>0 && A[15]!=0)?1'b1:1'b0)):(brtype[0]?((A==0)?1'b1:1'b0):1'b0);
endmodule

////////////////////

module PCsrc(pc,pcsrc,A,jump,en,nextaddr);
input en;
input [15:0]A;
input [15:0]pc;
input [1:0]pcsrc;
input[10:0]jump;
wire [15:0]pcincr;
output[15:0]nextaddr;
//00...J 01...JAL 10...JR 11...SysCall
assign pcincr = (({16{en}})&({{9{jump[6]}},jump[6:0]})) + 1'b1 + pc;
assign nextaddr = pcsrc[1]?(pcsrc[0]?16'hFF00:A):(pcsrc[0]?{pcincr[15:11],jump}:pcincr);
endmodule