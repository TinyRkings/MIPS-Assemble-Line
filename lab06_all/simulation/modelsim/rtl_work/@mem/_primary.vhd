library verilog;
use verilog.vl_types.all;
entity Mem is
    port(
        clk             : in     vl_logic;
        PC_out          : in     vl_logic_vector(31 downto 0);
        Mem_data_out    : out    vl_logic_vector(31 downto 0)
    );
end Mem;
