module Intruction 
#(
  parameter SIZE_CNT = 3,
  parameter CNT_CLK = 2
)
(
  input clk,
  input [SIZE_CNT:0]cnt_clk,
  input 	[3:0]Data_Addr,
  output reg [1:0] SM,
  output reg [3:0] OP,
  output	reg [3:0] Data1,
  output	reg [3:0] Data2,
  output reg [3:0] Data3
);
reg [17:0]INS_REGISTER [17:0];
initial 
begin
$readmemb("C:/DataRamVLSI/data.txt", INS_REGISTER);
end
always@(posedge clk)
begin
if(cnt_clk==CNT_CLK)
begin
SM 	=  INS_REGISTER[Data_Addr-1][17:16];
OP 	= 	INS_REGISTER[Data_Addr-1][15:12];
Data1 = 	INS_REGISTER[Data_Addr-1][11:8];
Data2 = 	INS_REGISTER[Data_Addr-1][7:4];
Data3 = 	INS_REGISTER[Data_Addr-1][3:0];
end
end
endmodule