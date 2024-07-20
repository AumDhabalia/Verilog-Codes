/* This block generates next possible address. The address is generated based on
jump or branchtype instructions. Current address is fed from program-counter to this block.
Last two bits are appended as pc jumps by a stride of "four memory bytes".
pc = Program Counter Address
A = Value from register1
B = Value from register2
pcsrc = Mode for selecting next type address
			pcincr/BrType...00
			jump & link............01
			jumpreturn......10
			SysCall.........11
Brtype = branch type instructions
			PCincr...00
			BEQ.......01
			BNE.....10
			BLTZ.....11
*/
module AddressGenerator32Bit(pc,A,B,pcsrc,brtype,jump,nextaddr,incrPC);
input [1:0]pcsrc,brtype;
input [25:0]jump;
input [31:0]A,B,pc;
output [31:0]nextaddr,incrPC;
wire en;
Branch br(brtype,A,B,en);
PCsrc pcaddr(pc[31:2],pcsrc,A[29:0],jump,en,nextaddr,incrPC);
endmodule

////////////////////

module Branch(brtype,A,B,en);
input [31:0]A,B;
input [1:0]brtype;
output en;
//00...PCincr 01...BEQ 10...BNE 11...BLTZ
assign en = brtype[1]?(brtype[0]?((A[31])?1'b0:1'b1):((A!=B)?1'b1:1'b0)):(brtype[0]?((A==B)?1'b1:1'b0):1'b0);
endmodule

////////////////////

module PCsrc(pc,pcsrc,A,jump,en,nextaddr,incrPC);
input en;
input [29:0]A;
input [29:0]pc;
input [1:0]pcsrc;
input[25:0]jump;
wire [31:0]pcincr;
output [31:0]nextaddr,incrPC;
//00...J 01...JAL 10...JR 11...SysCall
assign pcincr = (({32{en}})&({{14{jump[15]}},jump[15:0],2'b00})) + 3'b100 + {pc,2'b00};
assign nextaddr = pcsrc[1]?(pcsrc[0]?32'd58523:{A[29:0],2'b00}):(pcsrc[0]?{pcincr[31:28],jump,2'b00}:pcincr);
assign incrPC = pcincr;
endmodule