library verilog;
use verilog.vl_types.all;
entity Cnt_clk is
    generic(
        SIZE_CNT        : vl_notype
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        Cnt             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE_CNT : constant is 5;
end Cnt_clk;
