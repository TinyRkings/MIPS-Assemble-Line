library verilog;
use verilog.vl_types.all;
entity control_all is
    port(
        OP              : in     vl_logic_vector(5 downto 0);
        Rs              : in     vl_logic_vector(4 downto 0);
        Rt              : in     vl_logic_vector(4 downto 0);
        Func            : in     vl_logic_vector(5 downto 0);
        Regwr           : out    vl_logic;
        WBtype          : out    vl_logic_vector(3 downto 0);
        regdst          : out    vl_logic_vector(1 downto 0);
        Rt_out_shift_ctr: out    vl_logic_vector(2 downto 0);
        Mem_data_shift_ctr: out    vl_logic_vector(2 downto 0);
        Choice          : out    vl_logic;
        Mem_byte_wr_in  : out    vl_logic_vector(3 downto 0);
        MemRead         : out    vl_logic;
        Extend          : out    vl_logic_vector(1 downto 0);
        branch          : out    vl_logic;
        Jump            : out    vl_logic;
        condition       : out    vl_logic_vector(2 downto 0);
        ExResultSrc     : out    vl_logic_vector(2 downto 0);
        ALUsrcA         : out    vl_logic;
        ALUsrcB         : out    vl_logic;
        ALU_op          : out    vl_logic_vector(3 downto 0);
        Shift_amountSrc : out    vl_logic;
        Shift_op        : out    vl_logic_vector(1 downto 0)
    );
end control_all;
