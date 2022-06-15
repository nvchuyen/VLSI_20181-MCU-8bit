module MCU_8bit(
 input clk, reset
);
wire [3:0]cnt_clk;
wire PC_Ctr; 
wire [1:0] Mem_Ctr; 
wire [1:0] Reg_Ctr;
wire [3:0] ALU_Ctr;
wire ALU_IN, MemToReg,Reg_Dst,sl_WriteData;
wire [17:0] Data_Addr;
wire [1:0] SM;
wire [3:0] OP;
wire [3:0] Data1;
wire [3:0] Data2;
wire [3:0] Data3;
wire [7:0] Write_Data;
wire [7:0] Dout1;
wire [7:0] Dout2;
wire [7:0] DoutALU;
wire [7:0] DoutMem;
wire [3:0] FLAG_ALU;
wire [1:0] ALU_OP;
wire [7:0] ALU_IN2;
wire [7:0] Write_data;
wire [7:0] Write_Addr;
wire [7:0] Write_data_mem;
localparam size_cnt = 3;
localparam cnt_clk_pc = 1, cnt_clk_ins = 2, cnt_clk_control = 3, cnt_clk_reg = 4, cnt_clk_alu = 5, cnt_clk_mem = 6;

/*******  Cnt_clk *********/
 Cnt_clk 	#(.SIZE_CNT(size_cnt))               		  				cnt_clk1 		(.clk(clk),.reset(reset),.Cnt(cnt_clk));
 
 /***********   PC  *********/
 PC #(.SIZE_CNT(size_cnt),.CNT_CLK(cnt_clk_pc))							pc					(.clk(clk),.Cnt(cnt_clk),.PC_Control(PC_Ctr),.Count_ALU(Write_data),
																											.pc(Data_Addr));
 /**********  Intruction  *********/	
 Intruction #(.SIZE_CNT(size_cnt),.CNT_CLK(cnt_clk_ins))				Instr 			(.clk(clk),.cnt_clk(cnt_clk),.Data_Addr(Data_Addr),
																											.SM(SM),.OP(OP),.Data1(Data1),.Data2(Data2),.Data3(Data3));

/************* Control ****************/
 Control #(.SIZE_CNT(size_cnt),.CNT_CLK(cnt_clk_control))			Control 			(.clk(clk),.cnt_clk(cnt_clk),.OP(OP),.SM(SM),.FLAG_ALU(FLAG_ALU),
																											.PC_Ctr(PC_Ctr),
																											.Mem_Ctr(Mem_Ctr),.Reg_Ctr(Reg_Ctr),.ALU_Ctr(ALU_Ctr),
																											.ALU_IN(ALU_IN),.MemToReg(MemToReg),.Reg_Dst(Reg_Dst),.sl_WriteData(sl_WriteData));
/************** REG **************/
Register #(.SIZE_CNT(size_cnt),.CNT_CLK(cnt_clk_reg))				   Reg				(.cnt_clk(cnt_clk),.clk(clk),.WR(Reg_Ctr),
																											.Read_Addr1(Data1),.Read_Addr2(Data2),.Write_Addr(Write_Addr),
																											.Write_Data(Write_data),
																											.Dout1(Dout1),.Dout2(Dout2));		 
/************** ALU **************/
 ALU     #(.SIZE_CNT(size_cnt),.CNT_CLK(cnt_clk_alu))					alu		 	  (.clk(clk),.cnt_clk(cnt_clk),.SM(SM),.Op(ALU_Ctr),
																											.rs1(Dout1),.rs2(ALU_IN2),.rd(DoutALU),.flag(FLAG_ALU));
 			 
/************** MEM **************/					
Memory  #(.SIZE_CNT(size_cnt),.CNT_CLK(cnt_clk_mem))	   		   mem   		   (.cnt_clk(cnt_clk),.clk(clk),.WR(Mem_Ctr),.Addr(DoutALU),.Write_data(Write_data_mem),
																											.Dout(DoutMem));
						 
/**********  MUX  **************/
Mux     #(.Size_Data(7))														ALU_IN1       (.Control(ALU_IN),.In_Data1(Dout2),.In_Data2({4'b0,Data3}),.Out_Data(ALU_IN2));
Mux     #(.Size_Data(7))													   MemtoReg      (.Control(MemToReg),.In_Data1(DoutMem),.In_Data2(DoutALU),.Out_Data(Write_data));
Mux	  #(.Size_Data(3))														RegDst    	  (.Control(Reg_Dst),.In_Data1(Data1),.In_Data2(Data3),.Out_Data(Write_Addr));
Mux     #(.Size_Data(7))														SLWriteData   (.Control(sl_WriteData),.In_Data1(Dout1),.In_Data2({Data1,Data2}),.Out_Data(Write_data_mem));
endmodule