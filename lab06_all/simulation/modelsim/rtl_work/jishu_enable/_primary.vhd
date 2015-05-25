library verilog;
use verilog.vl_types.all;
entity jishu_enable is
    port(
        clk             : in     vl_logic;
        Memwrite        : in     vl_logic;
        jishu           : out    vl_logic
    );
end jishu_enable;
