library verilog;
use verilog.vl_types.all;
entity RegoutputShift is
    port(
        MemOp3          : in     vl_logic_vector(2 downto 0);
        Rt_out          : in     vl_logic_vector(31 downto 0);
        Mem_addr_in     : in     vl_logic_vector(1 downto 0);
        Rt_out_shift    : out    vl_logic_vector(31 downto 0)
    );
end RegoutputShift;
