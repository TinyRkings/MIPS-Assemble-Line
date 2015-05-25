library verilog;
use verilog.vl_types.all;
entity get_branch_jump_addr is
    port(
        add_pc2         : in     vl_logic_vector(31 downto 0);
        Immediate32_2   : in     vl_logic_vector(31 downto 0);
        Rs2             : in     vl_logic_vector(4 downto 0);
        Rt2             : in     vl_logic_vector(4 downto 0);
        branch_addr     : out    vl_logic_vector(31 downto 0);
        jump_addr       : out    vl_logic_vector(31 downto 0)
    );
end get_branch_jump_addr;
