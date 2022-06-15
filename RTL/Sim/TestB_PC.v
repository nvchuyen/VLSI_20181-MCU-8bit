module TestB_PC();
reg clk;
reg EN;
reg PC_Control;
reg [7:0]Count_ALU;
wire [7:0]pc;
PC pc1(.clk(clk),.Cnt(Cnt),.PC_Control(PC_Control),.Count_ALU(Count_ALU),.pc(pc));
  // setup clk
initial
begin
 clk = 0;
 forever #5 clk=~clk;
end
initial
begin
 EN = 1;
 PC_Control = 1;
 Count_ALU = 8'b0;
end
endmodule
