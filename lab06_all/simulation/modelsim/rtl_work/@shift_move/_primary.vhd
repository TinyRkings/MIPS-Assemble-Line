library verilog;
use verilog.vl_types.all;
entity Shift_move is
    port(
        Shift_in        : in     vl_logic_vector(31 downto 0);
        Shift_amountSrc : in     vl_logic;
        IR              : in     vl_logic_vector(10 downto 6);
        Rs_out          : in     vl_logic_vector(4 downto 0);
        Shift_op        : in     vl_logic_vector(1 downto 0);
        Shift_out       : out    vl_logic_vector(31 downto 0)
    );
end Shift_move;
