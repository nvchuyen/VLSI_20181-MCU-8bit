module TestB_MCU();
reg clk;
reg reset;
MCU_8bit mcu (.clk(clk),.reset(reset));
// setup clk
initial
begin
 clk = 1;
 forever #5 clk=~clk;
end
initial
begin
 reset = 1;
 #5
 reset = 0;
end
endmodule