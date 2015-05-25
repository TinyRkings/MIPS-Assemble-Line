library verilog;
use verilog.vl_types.all;
entity lab06_all is
    port(
        clk             : in     vl_logic;
        branch          : out    vl_logic;
        Jump            : out    vl_logic;
        jishu           : out    vl_logic;
        jishu2          : out    vl_logic;
        Memwrite        : out    vl_logic;
        newOperandB     : out    vl_logic_vector(31 downto 0);
        right_answer    : out    vl_logic_vector(31 downto 0);
        newOperandB_src : out    vl_logic_vector(1 downto 0);
        Jump2           : out    vl_logic;
        branch2         : out    vl_logic;
        PC_src          : out    vl_logic_vector(1 downto 0);
        jump_addr       : out    vl_logic_vector(31 downto 0);
        branch_addr     : out    vl_logic_vector(31 downto 0);
        Shift_out       : out    vl_logic_vector(31 downto 0);
        WriteData       : out    vl_logic_vector(31 downto 0);
        ALU_SrcA        : out    vl_logic_vector(1 downto 0);
        ALU_SrcB        : out    vl_logic_vector(1 downto 0);
        Rd_addr         : out    vl_logic_vector(4 downto 0);
        Rd_addr2        : out    vl_logic_vector(4 downto 0);
        WriteReg        : out    vl_logic_vector(4 downto 0);
        Regwr3          : out    vl_logic;
        Regwr4          : out    vl_logic;
        OperandA        : out    vl_logic_vector(31 downto 0);
        OperandB        : out    vl_logic_vector(31 downto 0);
        WBdata          : out    vl_logic_vector(31 downto 0);
        WBdata2         : out    vl_logic_vector(31 downto 0);
        right_Mem       : out    vl_logic_vector(31 downto 0);
        Mem_data_out    : out    vl_logic_vector(31 downto 0);
        PC_in           : out    vl_logic_vector(31 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0);
        A_in            : out    vl_logic_vector(31 downto 0);
        B_in            : out    vl_logic_vector(31 downto 0);
        Overflow        : out    vl_logic;
        Less            : out    vl_logic;
        OP              : out    vl_logic_vector(5 downto 0);
        Rs              : out    vl_logic_vector(4 downto 0);
        Rt              : out    vl_logic_vector(4 downto 0);
        Rd              : out    vl_logic_vector(4 downto 0);
        Shamt           : out    vl_logic_vector(4 downto 0);
        Func            : out    vl_logic_vector(5 downto 0);
        Immediate32_2   : out    vl_logic_vector(31 downto 0)
    );
end lab06_all;
