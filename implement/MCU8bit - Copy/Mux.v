module Mux 
#
(
 parameter Size_Data = 0  
)
(
   input Control,
	input [Size_Data:0] In_Data1,
	input [Size_Data:0] In_Data2,
	output reg [Size_Data:0] Out_Data
);
always @(*)
begin
Out_Data = (Control==1)? In_Data1:In_Data2;
end
endmodule 