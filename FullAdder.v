module FullAdder(A,B,Cin,S,Carry);
input A,B,Cin;
output S,Carry;
assign S = A^B^Cin;
assign Carry = (A&B)|(B&Cin)|(Cin&A);
endmodule