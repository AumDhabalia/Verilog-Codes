module BarrelShifter#(parameter N=32)(In,s,out1,out);
input [N-1:0]In;
input [4:0]s;
output [N-1:0]out;
output reg [N-1:0]out1;
always@(*)
begin
	case(s)
		5'd0: out1[N-1:0] = In[N-1:0];
		5'd1: out1[N-1:0] = {In[0],In[N-1:1]};
		5'd2: out1[N-1:0] = {In[1:0],In[N-1:2]};
		5'd3: out1[N-1:0] = {In[2:0],In[N-1:3]};
		5'd4: out1[N-1:0] = {In[3:0],In[N-1:4]};
		5'd5: out1[N-1:0] = {In[4:0],In[N-1:5]};
		5'd6: out1[N-1:0] = {In[5:0],In[N-1:6]};
		5'd7: out1[N-1:0] = {In[6:0],In[N-1:7]};
		5'd8: out1[N-1:0] = {In[7:0],In[N-1:8]};
		5'd9: out1[N-1:0] = {In[8:0],In[N-1:9]};
		5'd10: out1[N-1:0] = {In[9:0],In[N-1:10]};
		5'd11: out1[N-1:0] = {In[10:0],In[N-1:11]};
		5'd12: out1[N-1:0] = {In[11:0],In[N-1:12]};
		5'd13: out1[N-1:0] = {In[12:0],In[N-1:13]};
		5'd14: out1[N-1:0] = {In[13:0],In[N-1:14]};
		5'd15: out1[N-1:0] = {In[14:0],In[N-1:15]};
		5'd16: out1[N-1:0] = {In[15:0],In[N-1:16]};
		5'd17: out1[N-1:0] = {In[16:0],In[N-1:17]};
		5'd18: out1[N-1:0] = {In[17:0],In[N-1:18]};
		5'd19: out1[N-1:0] = {In[18:0],In[N-1:19]};
		5'd20: out1[N-1:0] = {In[19:0],In[N-1:20]};
		5'd21: out1[N-1:0] = {In[20:0],In[N-1:21]};
		5'd22: out1[N-1:0] = {In[21:0],In[N-1:22]};
		5'd23: out1[N-1:0] = {In[22:0],In[N-1:23]};
		5'd24: out1[N-1:0] = {In[23:0],In[N-1:24]};
		5'd25: out1[N-1:0] = {In[24:0],In[N-1:25]};
		5'd26: out1[N-1:0] = {In[25:0],In[N-1:26]};
		5'd27: out1[N-1:0] = {In[26:0],In[N-1:27]};
		5'd28: out1[N-1:0] = {In[27:0],In[N-1:28]};
		5'd29: out1[N-1:0] = {In[28:0],In[N-1:29]};
		5'd30: out1[N-1:0] = {In[29:0],In[N-1:30]};
		5'd31: out1[N-1:0] = {In[30:0],In[N-1]};
		default: out1 = In;
	endcase
end
assign out = out1;
endmodule
/*
y[0] = s[0];
y[1] = (~en&s[1])|(s[1]&~s[0])|(en&~s[1]&s[0]); 
y[2] = (~en&s[2])|(s[2]&~s[1]&~s[0])|en&~s[2]&(s[1]|s[0])
y[3] =
y[4] =
*/