library verilog;
use verilog.vl_types.all;
entity EX_MEM is
    port(
        clk             : in     vl_logic;
        WBtype2         : in     vl_logic_vector(3 downto 0);
        Regwr2          : in     vl_logic;
        Rd_enable       : in     vl_logic_vector(3 downto 0);
        Rd_addr         : in     vl_logic_vector(4 downto 0);
        MemRead2        : in     vl_logic;
        MemOp2          : in     vl_logic_vector(2 downto 0);
        CacheOp2        : in     vl_logic_vector(2 downto 0);
        Choice2         : in     vl_logic;
        Mem_byte_wr_in2 : in     vl_logic_vector(3 downto 0);
        Less            : in     vl_logic;
        Overflow        : in     vl_logic;
        Zero            : in     vl_logic;
        WBdata          : in     vl_logic_vector(31 downto 0);
        OperandB2       : in     vl_logic_vector(31 downto 0);
        WBtype3         : out    vl_logic_vector(3 downto 0);
        Regwr3          : out    vl_logic;
        Rd_enable2      : out    vl_logic_vector(3 downto 0);
        Rd_addr2        : out    vl_logic_vector(4 downto 0);
        MemRead3        : out    vl_logic;
        MemOp3          : out    vl_logic_vector(2 downto 0);
        CacheOp3        : out    vl_logic_vector(2 downto 0);
        Choice3         : out    vl_logic;
        Mem_byte_wr_in3 : out    vl_logic_vector(3 downto 0);
        Less2           : out    vl_logic;
        Overflow2       : out    vl_logic;
        Zero2           : out    vl_logic;
        WBdata2         : out    vl_logic_vector(31 downto 0);
        Memdata2        : out    vl_logic_vector(31 downto 0)
    );
end EX_MEM;
