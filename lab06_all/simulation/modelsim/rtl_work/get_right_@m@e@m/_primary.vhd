library verilog;
use verilog.vl_types.all;
entity get_right_MEM is
    port(
        Choice3         : in     vl_logic;
        data_out        : in     vl_logic_vector(31 downto 0);
        Mem_data_shift  : in     vl_logic_vector(31 downto 0);
        right_Mem       : out    vl_logic_vector(31 downto 0)
    );
end get_right_MEM;
