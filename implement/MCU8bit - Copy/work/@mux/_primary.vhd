library verilog;
use verilog.vl_types.all;
entity Mux is
    generic(
        Size_Data       : integer := 0
    );
    port(
        Control         : in     vl_logic;
        In_Data1        : in     vl_logic_vector;
        In_Data2        : in     vl_logic_vector;
        Out_Data        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Size_Data : constant is 1;
end Mux;
