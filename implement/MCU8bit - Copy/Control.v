module Control
#(
  parameter SIZE_CNT=0,
  parameter CNT_CLK=0 
)
(
		input[3:0] OP, 
    	input [1:0] SM, 
		input [2:0] FLAG_ALU,
		input clk,
		input [SIZE_CNT:0]cnt_clk,
		output reg [0:0]PC_Ctr,                   // pin control
		output reg [1:0]Mem_Ctr,
		output reg [1:0]Reg_Ctr,
		output reg[3:0] ALU_Ctr,
		output reg ALU_IN,                        // select mux3
		output reg MemToReg,								// select mux2
		output reg Reg_Dst,								// select mux1
		output reg sl_WriteData
);
parameter MEM  = 2'b00, ARITH = 2'b01, LOGIC = 2'b10, FLOW = 2'b11;
reg STATUS_END = 1'b0;
parameter START = 5'b0,PC_RUN = 1'b1, INS_RUN = 1'b1, RES_RUN = 1'b1, ALU_RUN = 1'b1, MEM_RUN = 1'b1;
initial
begin
PC_Ctr = 1;
end
always @(posedge clk)
begin
if(cnt_clk==CNT_CLK)
begin
if(SM==MEM)
	 begin
		 if(OP==4'b0000)        // ldi
		  begin
		   PC_Ctr  	= 1'b1;		// pc = pcnext +1
			Mem_Ctr 	= 2'b01;		// write data
			Reg_Ctr 	= 2'b00;    // read data
			ALU_Ctr 	= 4'b0000;  // select op:ldi
			ALU_IN  	= 1'b0;
			MemToReg	= 1'bz;
			Reg_Dst  = 1'b1;
			sl_WriteData = 1'b0;
		  end
		  	else if(OP==4'b0001)    // ldm
		  begin
		   PC_Ctr  	= 1'b1;		  // pc = pcnext +1
			Mem_Ctr 	= 2'b00;		  // read data
			Reg_Ctr 	= 2'b00;      // write data
			ALU_Ctr 	= 4'b0000;    // select op:sdm
			ALU_IN  	= 1'b0;
			MemToReg	= 1'b1;     
			Reg_Dst  = 1'b1;
			sl_WriteData = 1'b1;
		  end
		  	else if(OP==4'b0010)        // stm
		  begin
		   PC_Ctr  	= 1'b1;		 // pc = pcnext +1
			Mem_Ctr 	= 2'b01;		 //  Write data
			Reg_Ctr 	= 2'b00;     // read data
			ALU_Ctr 	= 4'b0000;   // select op:stm
			ALU_IN  	= 1'b0;
			MemToReg	= 1'bz;      // dont'n care
			Reg_Dst  = 1'b0;
			sl_WriteData = 1'b1;
		  end
	 end
	 else if (SM==ARITH)
	 begin
		 if(OP==4'b0001)           // ADD
		  begin
		   PC_Ctr  	= 1'b1;			// pc = pcnext +1
			Mem_Ctr 	= 2'b00;		   // don't care
			Reg_Ctr = 2'b00;        // read data
			ALU_Ctr 	= 4'b0001;     // select op:ADD
			ALU_IN  	= 1'b1;
			MemToReg	= 1'b0;			
			Reg_Dst  = 1'b0;
			sl_WriteData = 1'b1;
		  end
		  	else if(OP==4'b0010)     // SUB
		  begin
		   PC_Ctr  	= 1'b1;			// pc = pcnext +1
			Mem_Ctr 	= 2'b00;		   // don't care
	    	Reg_Ctr 	= 2'b00;       // read data
			ALU_Ctr 	= 4'b0010;     // select op: SUB
			ALU_IN  	= 1'b1;
			MemToReg	= 1'b0;			
			Reg_Dst  = 1'b0;
			sl_WriteData = 1'b1;
		  end
			else if(OP==4'b0000)        // Cmp
		  begin
		   PC_Ctr  	= 1'b1;			// pc = pcnext +1
			Mem_Ctr 	= 2'b00;		   // don't care
			Reg_Ctr 	= 2'b00;     // read data
			ALU_Ctr 	= 4'b0000;     // select op: Cmp
			ALU_IN  	= 1'b1;
			MemToReg	= 1'b0;			
			Reg_Dst  = 1'b0;
			sl_WriteData = 1'b1;
		  end
	 end
	 else if(SM==LOGIC)
	 begin
		 if(OP==4'b0000)        // AND
		  begin
		   PC_Ctr  	= 1'b1;			// pc = pcnext +1
			Mem_Ctr 	= 2'b00;		   // don't care
			Reg_Ctr 	= 2'b00;       // read data
			ALU_Ctr 	= 4'b0000;     // select op:AND
			ALU_IN  	= 1'b1;
			MemToReg	= 1'b0;			
			Reg_Dst  = 1'b0;
			sl_WriteData = 1'b1;
		  end
		  	else if(OP==4'b0001)        // OR
		  begin
		   PC_Ctr  	= 1'b1;			// pc = pcnext +1
			Mem_Ctr 	= 2'b00;		   // don't care
			Reg_Ctr 	= 2'b00;       // read data
			ALU_Ctr 	= 4'b0001;     // select op: OR
			ALU_IN  	= 1'b1;
			MemToReg	= 1'b0;			
			Reg_Dst  = 1'b0;
			sl_WriteData = 1'b1;
		  end
		   else if(OP==4'b0010)        // XOR
		  begin
		   PC_Ctr  	= 1'b1;			// pc = pcnext +1
			Mem_Ctr 	= 2'b00;		   // don't care
			Reg_Ctr 	= 2'b00;       // read data
			ALU_Ctr 	= 4'b0010;     // select op: XOR
			ALU_IN  	= 1'b1;
			MemToReg	= 1'b0;			
			Reg_Dst  = 1'b0;
			sl_WriteData = 1'b1;
		  end
		   else if(OP==4'b0011)        // not
		  begin
		   PC_Ctr  	= 1'b1;			// pc = pcnext +1
			Mem_Ctr 	= 2'b00;		   // don't care
			Reg_Ctr 	= 2'b00;       // read data
			ALU_Ctr 	= 4'b0011;     // select op: NOT
			ALU_IN  	= 1'b1;
			MemToReg	= 1'b0;			
			Reg_Dst  = 1'b0;
			sl_WriteData = 1'b1;
		  end
		  else
		  begin
		  PC_Ctr  	= 1'b1;			// pc = pcnext +1
			Mem_Ctr 	= 2'b00;		   // don't care
			Reg_Ctr 	= 2'bzz;       // read data
			ALU_Ctr 	= OP;          // shift op
			ALU_IN  	= 1'b1;
			MemToReg	= 1'b0;			
			Reg_Dst  = 1'b0;
			sl_WriteData = 1'b1;
		  end
	 end
	 else if(SM==FLOW)
	 begin
		 if(OP==4'b0000)            // JUMP
		  begin
		   PC_Ctr  	= 1'b0;			// pc = pc JUMP
			Mem_Ctr 	= 2'bzz;		   // don't care
			Reg_Ctr 	= 2'bzz;       // don't care
			ALU_Ctr 	= 4'b0000;     // select op:JUMP
			ALU_IN  	= 1'b0;			// select imm/addr
			MemToReg	= 1'b0;			// select imm/addr  
			Reg_Dst  = 1'bz;        // don't care
			sl_WriteData = 1'b1;
		  end
	 end
end
else if (cnt_clk==CNT_CLK+1)
begin
if(SM==ARITH || SM==LOGIC||OP==4'b0001)
begin
Reg_Ctr 	= 2'b01;    // writedata
end
end
//else if (cnt_clk ==0)
//begin
//			PC_Ctr  	= 1'bz;		// pc = pcnext +1
//			Mem_Ctr 	= 2'bzz;		// write data
//			Reg_Ctr 	= 2'bzz;    // read data
//			ALU_Ctr 	= 4'bzzzz;  // select op:ldi
//			ALU_IN  	= 1'bz;
//			MemToReg	= 1'bz;
//			Reg_Dst  = 1'bz;
//			sl_WriteData = 1'bz;
//end
end
// control run block
endmodule