library verilog;
use verilog.vl_types.all;
entity Intruction is
    generic(
        SIZE_CNT        : integer := 3;
        \CNT_CLK\       : integer := 2
    );
    port(
        clk             : in     vl_logic;
        cnt_clk         : in     vl_logic_vector;
        Data_Addr       : in     vl_logic_vector(3 downto 0);
        SM              : out    vl_logic_vector(1 downto 0);
        OP              : out    vl_logic_vector(3 downto 0);
        Data1           : out    vl_logic_vector(3 downto 0);
        Data2           : out    vl_logic_vector(3 downto 0);
        Data3           : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE_CNT : constant is 1;
    attribute mti_svvh_generic_type of \CNT_CLK\ : constant is 1;
end Intruction;
