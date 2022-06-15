library verilog;
use verilog.vl_types.all;
entity PC is
    generic(
        SIZE_CNT        : integer := 3;
        CNT_CLK         : integer := 1
    );
    port(
        clk             : in     vl_logic;
        Cnt             : in     vl_logic_vector;
        PC_Control      : in     vl_logic;
        Count_ALU       : in     vl_logic_vector(3 downto 0);
        pc              : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE_CNT : constant is 1;
    attribute mti_svvh_generic_type of CNT_CLK : constant is 1;
end PC;
