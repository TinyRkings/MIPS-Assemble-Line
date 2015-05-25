library verilog;
use verilog.vl_types.all;
entity MEM_WB is
    port(
        clk             : in     vl_logic;
        WBtype3         : in     vl_logic_vector(3 downto 0);
        Regwr3          : in     vl_logic;
        right_Mem       : in     vl_logic_vector(31 downto 0);
        WBdata2         : in     vl_logic_vector(31 downto 0);
        MemRead3        : in     vl_logic;
        Rd_addr2        : in     vl_logic_vector(4 downto 0);
        Rd_enable2      : in     vl_logic_vector(3 downto 0);
        WriteData       : out    vl_logic_vector(31 downto 0);
        WriteReg        : out    vl_logic_vector(4 downto 0);
        Rd_write_byte_en: out    vl_logic_vector(3 downto 0);
        Regwr4          : out    vl_logic;
        WBtype4         : out    vl_logic_vector(3 downto 0)
    );
end MEM_WB;
