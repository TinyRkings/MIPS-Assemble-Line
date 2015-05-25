library verilog;
use verilog.vl_types.all;
entity update_input_ALU is
    port(
        newOperandB_src : in     vl_logic_vector(1 downto 0);
        ALUSrcA2        : in     vl_logic;
        right_answer    : in     vl_logic_vector(31 downto 0);
        WriteData       : in     vl_logic_vector(31 downto 0);
        ALU_SrcA        : in     vl_logic_vector(1 downto 0);
        ALU_SrcB        : in     vl_logic_vector(1 downto 0);
        OperandA2       : in     vl_logic_vector(31 downto 0);
        OperandB2       : in     vl_logic_vector(31 downto 0);
        Immediate32_2   : in     vl_logic_vector(31 downto 0);
        A_in            : out    vl_logic_vector(31 downto 0);
        B_in            : out    vl_logic_vector(31 downto 0);
        newOperandB     : out    vl_logic_vector(31 downto 0)
    );
end update_input_ALU;
