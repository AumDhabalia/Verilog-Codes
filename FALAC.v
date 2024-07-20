module FALAC(sum,c_out,a,b,c_in);
output [3:0] sum;
output c_out;
input [3:0] a,b;
input c_in;
wire [3:0] p,g;
wire c1,c2,c3,c4;
assign p[0] = a[0]^b[0];
assign p[1] = a[1]^b[1];
assign p[2] = a[2]^b[2];
assign p[3] = a[3]^b[3];
assign g[0] = a[0]&b[0];
assign g[1] = a[1]&b[1];
assign g[2] = a[2]&b[2];
assign g[3] = a[3]&b[3];
assign c1 = g[0]|(p[0]&c_in);
assign c2 = g[1]|(p[1]&g[0])|(p[1]&p[0]&c_in);
assign c3 = g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&c_in);
assign c4 = g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&p[1]&p[0]&c_in);
assign sum[0] = p[0]^c_in;
assign sum[1] = p[1]^c1;
assign sum[2] = p[2]^c2;
assign sum[3] = p[3]^c3;
assign c_out = c4;
endmodule