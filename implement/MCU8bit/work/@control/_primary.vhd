library verilog;
use verilog.vl_types.all;
entity Control is
    generic(
        SIZE_CNT        : integer := 0;
        \CNT_CLK\       : integer := 0
    );
    port(
        OP              : in     vl_logic_vector(3 downto 0);
        SM              : in     vl_logic_vector(1 downto 0);
        FLAG_ALU        : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic;
        cnt_clk         : in     vl_logic_vector;
        PC_Ctr          : out    vl_logic_vector(0 downto 0);
        Mem_Ctr         : out    vl_logic_vector(1 downto 0);
        Reg_Ctr         : out    vl_logic_vector(1 downto 0);
        ALU_Ctr         : out    vl_logic_vector(3 downto 0);
        ALU_IN          : out    vl_logic;
        MemToReg        : out    vl_logic;
        Reg_Dst         : out    vl_logic;
        sl_WriteData    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SIZE_CNT : constant is 1;
    attribute mti_svvh_generic_type of \CNT_CLK\ : constant is 1;
end Control;
