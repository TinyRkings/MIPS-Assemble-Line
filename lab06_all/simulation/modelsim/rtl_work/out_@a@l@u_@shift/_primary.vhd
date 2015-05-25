library verilog;
use verilog.vl_types.all;
entity out_ALU_Shift is
    port(
        PC_out          : in     vl_logic_vector(31 downto 0);
        ALU_out         : in     vl_logic_vector(31 downto 0);
        Shift_out       : in     vl_logic_vector(31 downto 0);
        ALUShift_sel    : in     vl_logic_vector(2 downto 0);
        ALUShift_out    : out    vl_logic_vector(31 downto 0)
    );
end out_ALU_Shift;
