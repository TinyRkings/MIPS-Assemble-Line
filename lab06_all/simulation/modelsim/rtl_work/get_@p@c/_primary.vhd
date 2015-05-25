library verilog;
use verilog.vl_types.all;
entity get_PC is
    port(
        clk             : in     vl_logic;
        PC_in           : in     vl_logic_vector(31 downto 0);
        PC              : out    vl_logic_vector(31 downto 0)
    );
end get_PC;
