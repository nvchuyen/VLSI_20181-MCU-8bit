module TestB_Instruction();
  reg 	EN;
  reg		clk;
  reg 	[17:0]Data_Addr;
  reg    [17:0] Data_OP;
  wire 	[1:0] SM;
  wire 	[3:0] OP;
  wire	[3:0]	Data1;
  wire	[3:0] Data2;
  wire 	[3:0] Data3;
 Intruction ins1 (.EN(EN),.clk(clk),.Data_Addr(Data_Addr),.Data_OP(Data_OP),
						.SM(SM),.OP(OP),.Data1(Data1),.Data2(Data2),.Data3(Data3));

// create clk
initial
begin
 clk = 1;
 forever #5 clk=~clk;
end

initial
begin
  EN = 1;
  Data_Addr =18'b0;
  Data_OP = 18'b01_1100_1100_1100_0010;
end
endmodule