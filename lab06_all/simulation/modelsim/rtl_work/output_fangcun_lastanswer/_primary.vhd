library verilog;
use verilog.vl_types.all;
entity output_fangcun_lastanswer is
    port(
        WBdata2         : in     vl_logic_vector(31 downto 0);
        right_Mem       : in     vl_logic_vector(31 downto 0);
        MemRead3        : in     vl_logic;
        right_answer    : out    vl_logic_vector(31 downto 0)
    );
end output_fangcun_lastanswer;
