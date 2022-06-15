library verilog;
use verilog.vl_types.all;
entity MCU_8bit is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end MCU_8bit;
