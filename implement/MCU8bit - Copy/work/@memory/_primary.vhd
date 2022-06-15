library verilog;
use verilog.vl_types.all;
entity Memory is
    generic(
        SIZE_CNT        : vl_notype;
        \CNT_CLK\       : vl_notype
    );
    port(
        cnt_clk         : in     vl_logic_vector;
        clk             : in     vl_logic;
        WR              : in     vl_logic;
        Addr            : in     vl_logic_vector(3 downto 0);
        Write_data      : in     vl_logic_vector(7 downto 0);
        Dout            : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE_CNT : constant is 5;
    attribute mti_svvh_generic_type of \CNT_CLK\ : constant is 5;
end Memory;
