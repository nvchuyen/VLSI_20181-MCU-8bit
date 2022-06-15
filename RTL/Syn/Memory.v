module Memory
#(
  parameter SIZE_CNT,
  parameter CNT_CLK
)
(
  input 	[SIZE_CNT:0]cnt_clk,
  input  clk,
  input 	WR,
  input [3:0] 	Addr,
  input [7:0] 	Write_data,
  output reg [7:0] Dout
);
reg [7:0] Mem_REGISTER [15:0];
// inital Data on memory
//initial                
//begin
//$readmemh("D:/VLSI/Code_MCU/Control/Data_Ram.txt", Mem_REGISTER);
//end
always @(posedge clk)
begin
  if(cnt_clk==CNT_CLK+1&&WR==1)
  begin
    Mem_REGISTER[Addr] = Write_data;
	 end
	 else if(cnt_clk==CNT_CLK+1&&WR==0)
	 begin
	 Dout = Mem_REGISTER[Addr];
	 end
end
endmodule