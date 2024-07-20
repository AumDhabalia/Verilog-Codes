module ShiftRegister (IP,CLK,OP);
input IP;
input CLK;
output OP;
wire [2:0] d; 
  dflipflop dff1 (IP,CLK,d[0]);
  dflipflop dff2 (d[0],CLK,d[1]);
  dflipflop dff3 (d[1],CLK,d[2]);
  dflipflop dff4 (d[2],CLK,OP);
endmodule

module dflipflop (D,CLK,Q);
input D;
input CLK;
output reg Q;
always @(posedge CLK)
begin
  Q <= D;
end
endmodule