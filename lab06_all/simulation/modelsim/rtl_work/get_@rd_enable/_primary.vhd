library verilog;
use verilog.vl_types.all;
entity get_Rd_enable is
    port(
        WBtype2         : in     vl_logic_vector(3 downto 0);
        WBdata          : in     vl_logic_vector(1 downto 0);
        Overflow        : in     vl_logic;
        Mem_byte_wr_in2 : in     vl_logic_vector(3 downto 0);
        Rd_write_byte_en: out    vl_logic_vector(3 downto 0);
        rig_Mem_byte_wr_in: out    vl_logic_vector(3 downto 0)
    );
end get_Rd_enable;
