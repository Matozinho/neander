library ieee;
use ieee.std_logic_1164.all;

entity pc is
  port(
    cl, clk : in std_logic;
    bus_i    : in std_logic_vector(7 downto 0);
    bus_inc : in std_logic;
    pc_rw    : in std_logic;
    address_out  : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behavior of pc is

  component fadder8 is
    port(
      a, b : in  std_logic_vector(7 downto 0);
      cin  : in  std_logic;
      s    : out std_logic_vector(7 downto 0);
      cout : out std_logic
    );
  end component;

  component pc_mux is
    port(
      bus_i    : in std_logic_vector(7 downto 0);
      inc     : in std_logic_vector(7 downto 0);
      bus_inc : in std_logic;
      s       : out std_logic_vector(7 downto 0)
    );
  end component;

  component rip is
    port(
      din     : in std_logic_vector(7 downto 0);
      cl, clk : in std_logic;
      pc_rw    : in std_logic;
      dout    : out std_logic_vector(7 downto 0)
    );
  end component;

  signal s_current_pc       : std_logic_vector(7 downto 0);
  signal add_out, s_mux_pc  : std_logic_vector(7 downto 0);

begin

  u_add     : fadder8 port map("00000001", s_current_pc, '0', add_out);

  u_mux     : pc_mux port map(bus_i, add_out, bus_inc, s_mux_pc);

  u_pc   : rip port map(s_mux_pc, cl, clk, pc_rw, s_current_pc);

  address_out <= s_current_pc;

end architecture;
