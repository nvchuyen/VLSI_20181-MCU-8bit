library verilog;
use verilog.vl_types.all;
entity \Register\ is
    generic(
        SIZE_CNT        : vl_notype;
        \CNT_CLK\       : vl_notype
    );
    port(
        cnt_clk         : in     vl_logic_vector;
        clk             : in     vl_logic;
        WR              : in     vl_logic;
        Read_Addr1      : in     vl_logic_vector(3 downto 0);
        Read_Addr2      : in     vl_logic_vector(3 downto 0);
        Write_Addr      : in     vl_logic_vector(3 downto 0);
        Write_Data      : in     vl_logic_vector(7 downto 0);
        Dout1           : out    vl_logic_vector(7 downto 0);
        Dout2           : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE_CNT : constant is 5;
    attribute mti_svvh_generic_type of \CNT_CLK\ : constant is 5;
end \Register\;
