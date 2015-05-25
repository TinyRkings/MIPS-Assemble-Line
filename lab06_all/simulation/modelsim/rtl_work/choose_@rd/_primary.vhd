library verilog;
use verilog.vl_types.all;
entity choose_Rd is
    port(
        regdst2         : in     vl_logic_vector(1 downto 0);
        Rd2             : in     vl_logic_vector(4 downto 0);
        Rt2             : in     vl_logic_vector(4 downto 0);
        Rd_addr         : out    vl_logic_vector(4 downto 0)
    );
end choose_Rd;
