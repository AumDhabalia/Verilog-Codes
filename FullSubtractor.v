module FullSubtractor(A,B,Bin,D,Bout);
input wire A,B,Bin;
output reg D,Bout;
always@(A or B or Bin)
begin
 if(A==0 && B==0 && Bin==0)
  begin
   D=0;
   Bout=0;
  end
 else if(A==0 && B==0 && Bin==1)
  begin
   D=1;
   Bout=1;
  end
 else if(A==0 && B==1 && Bin==0)
  begin
   D=1;
   Bout=1;
  end
 else if(A==0 && B==1 && Bin==1)
  begin
   D=0;
   Bout=1;
  end
 else if(A==1 && B==0 && Bin==0)
  begin
   D=1;
   Bout=0;
  end
 else if(A==1 && B==0 && Bin==1)
  begin
   D=0;
   Bout=0;
  end
 else if(A==1 && B==1 && Bin==0)
  begin
   D=0;
   Bout=0;
  end
 else if(A==1 && B==1 && Bin==1)
  begin
   D=1;
   Bout=1;
  end
end
endmodule