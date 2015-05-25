library verilog;
use verilog.vl_types.all;
entity Read_datacache is
    port(
        clk             : in     vl_logic;
        jishu           : in     vl_logic;
        WBdata2         : in     vl_logic_vector(31 downto 0);
        Memdata2        : in     vl_logic_vector(31 downto 0);
        Mem_byte_wr_in3 : in     vl_logic_vector(3 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0)
    );
end Read_datacache;
