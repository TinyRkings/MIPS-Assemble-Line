library verilog;
use verilog.vl_types.all;
entity test_risk is
    port(
        clk             : in     vl_logic;
        Jump2           : in     vl_logic;
        branch3         : in     vl_logic;
        Condition2      : in     vl_logic_vector(2 downto 0);
        Less            : in     vl_logic;
        Zero            : in     vl_logic;
        PC_src          : out    vl_logic_vector(1 downto 0);
        Regwrite        : out    vl_logic;
        Memwrite        : out    vl_logic
    );
end test_risk;
