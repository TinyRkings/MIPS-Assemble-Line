library verilog;
use verilog.vl_types.all;
entity jishu_r_enable is
    port(
        clk             : in     vl_logic;
        Regwrite        : in     vl_logic;
        jishu2          : out    vl_logic
    );
end jishu_r_enable;
