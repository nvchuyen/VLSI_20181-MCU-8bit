module TestB_Register ();
 reg EN;
 reg clk;
 reg WR;
 reg [3:0]Read_Addr1;
 reg [3:0]Read_Addr2;
 reg [3:0]Write_Addr;
 reg [7:0]Write_Data;
 wire[7:0]Dout1;
 wire[7:0]Dout2;
 
 Register re1 (.EN(EN),.clk(clk),.WR(WR),
					.Read_Addr1(Read_Addr1),.Read_Addr2(Read_Addr2),
					.Write_Addr(Write_Addr),.Write_Data(Write_Data),
					.Dout1(Dout1),.Dout2(Dout2));
initial 
begin
 clk = 1;
 forever #5 clk=~clk;
end

initial
begin
EN = 1;
WR = 1; //Write
Write_Addr = 4'b0000;
Write_Data = 8'b1111_1111;
#50
Write_Addr = 4'b0001;
Write_Data = 8'b1111_0111;
#50
WR = 0;
Read_Addr2 = 4'b0000;
Read_Addr1 = 4'b0001;
end
endmodule