library verilog;
use verilog.vl_types.all;
entity registers_all is
    port(
        clk             : in     vl_logic;
        WBtype4         : in     vl_logic_vector(3 downto 0);
        jishu2          : in     vl_logic;
        rs_addr         : in     vl_logic_vector(4 downto 0);
        rt_addr         : in     vl_logic_vector(4 downto 0);
        rd_addr         : in     vl_logic_vector(4 downto 0);
        rd_in           : in     vl_logic_vector(31 downto 0);
        Rd_write_byte_en: in     vl_logic_vector(3 downto 0);
        rs_out          : out    vl_logic_vector(31 downto 0);
        rt_out          : out    vl_logic_vector(31 downto 0)
    );
end registers_all;
