module PC
#(
  parameter SIZE_CNT=3,
  parameter CNT_CLK=1
)
(clk,Cnt, PC_Control, Count_ALU, pc);
parameter N=4;
input clk;
input [SIZE_CNT:0]Cnt;
input PC_Control;
input [N-1:0]Count_ALU;
output [N-1:0]pc;
reg [N-1:0]pc_current;
wire [N-1:0]pc_next, pc2;
initial begin
	pc_current <= 4'b0;
	end
always @(posedge clk)
	begin 
	if(Cnt==CNT_CLK)
	begin
	pc_current <= pc_next;
	end
	end
	assign pc2 =(PC_Control==0)? Count_ALU:(pc_current +  4'b0001);
	//assign pc2 = pc_current +  8'b0000_0001;
	assign pc_next = pc2;
	assign pc = pc_current;
endmodule