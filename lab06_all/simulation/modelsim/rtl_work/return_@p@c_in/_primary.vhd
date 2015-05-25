library verilog;
use verilog.vl_types.all;
entity return_PC_in is
    port(
        add_pc          : in     vl_logic_vector(31 downto 0);
        Jump_addr       : in     vl_logic_vector(31 downto 0);
        branch_addr2    : in     vl_logic_vector(31 downto 0);
        PC_src          : in     vl_logic_vector(1 downto 0);
        PC_in           : out    vl_logic_vector(31 downto 0)
    );
end return_PC_in;
