module BoothMultiplier(A,M,Q);
output reg signed [7:0] A;
input signed [3:0] M,Q;
reg [1:0] temp;
integer i;
reg Q1;
reg [3:0] Q2;
always @(M,Q)
	begin
		A = 8'b0; Q1 = 1'b0; Q2 = -Q;
		for(i=0;i<4;i=i+1)
		begin
		temp = {M[i],Q1};
      case(temp)
        2'd2 : A[7:4] = A[7:4] + Q2;
        2'd1 : A[7:4] = A[7:4] + Q;
      endcase
      A = A>>1;
      A[7] = A[6];
      Q1=M[i];
    end
   end
endmodule