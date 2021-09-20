library ieee;
use ieee.std_logic_1164.all;

entity neander is
  port(
    cl, clk : in std_logic
  );
end entity;

architecture behavior of neander is
  component alu is
    port(
      rst, clk  : in std_logic;
      mem_data   : inout std_logic_vector(7 downto 0);
      alu_op     : in std_logic_vector(2 downto 0);
      ac_rw      : in std_logic;
      mem_rw     : in std_logic;
      flags_out     : out std_logic_vector(1 downto 0)
    );
  end component;

  component mem is
    port(
      rst, clk  : in std_logic;
      pc_address     : in std_logic_vector(7 downto 0);
      bus_address    : in std_logic_vector(7 downto 0);
      pc_bus    : in std_logic;
      mar_rw     : in std_logic;
      mem_rw     : in std_logic;
      mdr_rw     : in std_logic;
      bus_int    : inout std_logic_vector(7 downto 0)
    );
  end component;

  component cu is
    port(
      cl, clk     : in std_logic;
      nz          : in std_logic_vector(1 downto 0);
      data_bus   : inout std_logic_vector(7 downto 0);
      pc_out       : out std_logic_vector(7 downto 0);
      control_bus    : out std_logic_vector(10 downto 0)
    );
  end component;



  signal s_nz : std_logic_vector(1 downto 0);
  signal s_data_bus, s_pc_out : std_logic_vector(7 downto 0);
  signal s_control_bus : std_logic_vector(10 downto 0);
  signal s_alu_op : std_logic_vector(2 downto 0);

begin

  u_uc : cu port map(cl, clk, s_nz, s_data_bus, s_pc_out, s_control_bus);

  s_alu_op(2) <= s_control_bus(8);
  s_alu_op(1) <= s_control_bus(7);
  s_alu_op(0) <= s_control_bus(6);

  u_alu : alu port map(cl, clk, s_data_bus, s_alu_op, s_control_bus(4), s_control_bus(3), s_nz);

  u_mem : mem port map(cl, clk, s_pc_out, s_data_bus, s_control_bus(9), s_control_bus(2), s_control_bus(3), s_control_bus(1), s_data_bus);

end architecture;
