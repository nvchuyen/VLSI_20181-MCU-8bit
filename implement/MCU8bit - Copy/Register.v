module Register 
#(
  parameter SIZE_CNT,
  parameter CNT_CLK
)
(
 input [SIZE_CNT:0]cnt_clk,
 input clk,
 input WR,
 input [3:0]Read_Addr1,
 input [3:0]Read_Addr2,
 input [3:0]Write_Addr,
 input [7:0]Write_Data,
 output reg [7:0]Dout1,
 output reg [7:0]Dout2
);
reg [7:0] REGISTER [15:0];
always@(posedge clk)
begin
   if(cnt_clk==CNT_CLK||cnt_clk==CNT_CLK+4)
	begin
	if(WR==1)
	begin
	REGISTER[Write_Addr] = Write_Data;
	end
	else if(WR==0)
	begin
	Dout1 = REGISTER[Read_Addr1];
	Dout2 = REGISTER[Read_Addr2];
	end
	end
end
endmodule