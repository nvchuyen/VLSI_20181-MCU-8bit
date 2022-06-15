library verilog;
use verilog.vl_types.all;
entity ALU is
    generic(
        SIZE_CNT        : vl_notype;
        \CNT_CLK\       : vl_notype
    );
    port(
        clk             : in     vl_logic;
        cnt_clk         : in     vl_logic_vector;
        SM              : in     vl_logic_vector(1 downto 0);
        Op              : in     vl_logic_vector(3 downto 0);
        rs1             : in     vl_logic_vector(7 downto 0);
        rs2             : in     vl_logic_vector(7 downto 0);
        flag_C          : in     vl_logic;
        flag_Z          : in     vl_logic;
        rd              : out    vl_logic_vector(7 downto 0);
        flag            : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE_CNT : constant is 5;
    attribute mti_svvh_generic_type of \CNT_CLK\ : constant is 5;
end ALU;
