library verilog;
use verilog.vl_types.all;
entity Zhuanfa_unit is
    port(
        Rs2             : in     vl_logic_vector(4 downto 0);
        Rt2             : in     vl_logic_vector(4 downto 0);
        Rd_addr2        : in     vl_logic_vector(4 downto 0);
        WriteReg        : in     vl_logic_vector(4 downto 0);
        Regwr3          : in     vl_logic;
        Regwr4          : in     vl_logic;
        ALUSrc          : in     vl_logic;
        ALUSrcA         : out    vl_logic_vector(1 downto 0);
        ALUSrcB         : out    vl_logic_vector(1 downto 0);
        newOperandB_src : out    vl_logic_vector(1 downto 0)
    );
end Zhuanfa_unit;
