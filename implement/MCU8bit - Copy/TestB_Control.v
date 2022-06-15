module TestB_Control();
reg clk, rst;
reg[3:0] OP; 
reg [1:0] SM; 
reg [1:0] Flag;
wire  PC_E,REG_E,ALU_E,MEM_E;        // enable block
wire [0:0]PC_Ctr;                   // pin control
wire [1:0]Mem_Ctr;
wire [1:0]Reg_Ctr;
wire [3:0] ALU_Ctr;
wire ALU_IN;                        // select mux3
wire MemToReg;								// select mux2
wire Reg_Dst;								// select mux1
Control Control1 (.clk(clk),.rst(rst),.OP(OP),.SM(SM),.Flag(Flag),
						.PC_E(PC_E),.REG_E(REG_E),.ALU_E(ALU_E),.MEM_E(MEM_E),
						.PC_Ctr(PC_Ctr),.Mem_Ctr(Mem_Ctr),.Reg_Ctr(Reg_Ctr),
						.ALU_Ctr(ALU_Ctr),.ALU_IN(ALU_IN),.MemToReg(MemToReg),
						.Reg_Dst(Reg_Dst));
// tao clk
initial 
begin
 clk = 1;
 forever #5 clk=~clk;
end
initial
begin
rst  = 0;
#5 
rst  = 1;
OP  = 4'b0001;
SM = 2'b01;
end
endmodule