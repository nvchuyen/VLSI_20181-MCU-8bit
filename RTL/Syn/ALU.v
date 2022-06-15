module ALU
#(
  parameter SIZE_CNT,
  parameter CNT_CLK
)
(clk, cnt_clk, SM, Op, rs1, rs2, flag_C, flag_Z, rd, flag);
parameter N=8;
input clk;
input [SIZE_CNT:0]cnt_clk;
input [1:0]SM;
input [3:0]Op;
input [N-1:0]rs1, rs2;
input flag_C, flag_Z;
output reg [N-1:0]rd;
output reg [3:0] flag;
parameter ALU_RUN = 1'b1;
reg [N-1:0]Out;
reg [N-1:0]D_Out;
always @(posedge clk )
begin
 if(cnt_clk==CNT_CLK)
begin
case(SM)
	2'b00:// memory access
		begin
			case(Op)
				4'b0000: Out = rs2;//Ldi
				4'b0001: Out = rs2;//Ldm
				4'b0010: Out = rs2;//Stm
				endcase
		end
	2'b01://arithmetic
		begin
			case(Op)
				4'b0000: flag[3] = (rs1 >= rs2) ? 1'b1:1'b0;// cmp: so sanh hai thanh ghi
				4'b0001: {flag[0],Out[N-1:0]} = rs1[N-1:0] + rs2[N-1:0];// add: cong toan hoc
				4'b0010:  Out = rs1-rs2;// sub: tru toan hoc
				endcase
		end
	
	2'b10:  //logic
		begin
			case(Op)
				4'b0000: Out = rs1 & rs2 ;//and
				4'b0001: Out = rs1 | rs2 ;//or
				4'b0010: Out = rs1 ^ rs2 ;//xor
				4'b0011: Out = ~rs1 ;//not
				4'b0100: Out = {rs1[N-2:0],1'b0} ; //sl0-dich trai va them 0 vao vi tri trong
				4'b0101: Out = {rs1[N-2:0],1'b1}; //sl1
				4'b0110: Out = {1'b0,rs1[N-2:0]}; //sr0// dich phai và thêm 0 vào vị trí trống
				4'b0111: Out = {1'b1,rs1[N-2:0]}; //sr1
				4'b1000: Out = {rs1[N-2:0], rs1[N-1]} ; //rrr-quay vòng trái
				4'b1001: Out = {rs1[0], rs1[N-1:1]}; //rrl-quay vòng phải
				endcase
		end
	2'b11://flow control
		begin
			case(Op)
				4'b0000: Out = rs2;// nhảy khi gặp lệnh này
				4'b0001: begin if(flag_Z ==0) Out = rs2<<4 + rs1; end//Nhảy nếu cờ zero bật lên là 1
				4'b0010: begin if(flag_Z ==1) Out = rs2<<4 + rs1; end//Nhảy nếu cờ zero bật lên là 0
				4'b0011: begin if(flag_C ==0) Out = rs2<<4 + rs1; end//Nhảy nếu cờ carry bật lên là 1
				4'b0100:	begin if(flag_C ==1) Out = rs2<<4 + rs1; end//Nhảy nếu cờ carry bật lên là 0
				endcase
		end
endcase
end
end
always @(posedge clk)
begin
 if(cnt_clk==CNT_CLK+1)
  rd = Out;
end
//	assign flag[0] = (EN ==1)? flag[0]: 1'bz;
//	assign flag[1] = (EN ==1)? flag[1]: 1'bz;
//	assign flag[2] = (EN ==1)? flag[2]: 1'bz;
//	assign flag[3] = (EN ==1)? flag[3]: 1'bz;
endmodule
