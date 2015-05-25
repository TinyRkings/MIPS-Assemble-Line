library verilog;
use verilog.vl_types.all;
entity get_imm32 is
    port(
        Rd              : in     vl_logic_vector(4 downto 0);
        Shamt           : in     vl_logic_vector(4 downto 0);
        Func            : in     vl_logic_vector(5 downto 0);
        Extend          : in     vl_logic_vector(1 downto 0);
        Immediate32     : out    vl_logic_vector(31 downto 0)
    );
end get_imm32;
