library verilog;
use verilog.vl_types.all;
entity IF_ID is
    port(
        clk             : in     vl_logic;
        PC_out          : in     vl_logic_vector(31 downto 0);
        Mem_data_out    : in     vl_logic_vector(31 downto 0);
        add_pc          : out    vl_logic_vector(31 downto 0);
        OP              : out    vl_logic_vector(5 downto 0);
        Rs              : out    vl_logic_vector(5 downto 0);
        Rt              : out    vl_logic_vector(5 downto 0);
        Rd              : out    vl_logic_vector(5 downto 0);
        Shamt           : out    vl_logic_vector(5 downto 0);
        Func            : out    vl_logic_vector(5 downto 0)
    );
end IF_ID;
