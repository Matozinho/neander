library ieee;
use ieee.std_logic_1164.all;

entity mem is
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
end entity;

architecture behavior of mem is

  component mem_mux is
    port(
      pc_address   : in std_logic_vector(7 downto 0);
      bus_address  : in std_logic_vector(7 downto 0);
      pc_bus  : in std_logic;
      s       : out std_logic_vector(7 downto 0)
    );
  end component;

  component mar is
    port(
      din     : in std_logic_vector(7 downto 0);
      cl, clk : in std_logic;
      mar_rw   : in std_logic;
      dout    : out std_logic_vector(7 downto 0)
    );
  end component;

  component mdr is
    port(
      din     : in std_logic_vector(7 downto 0);
      cl, clk : in std_logic;
      mdr_rw    : in std_logic;
      dout    : out std_logic_vector(7 downto 0)
    );
  end component;

  component as_ram is
    port(
      addr  : in    std_logic_vector(7 downto 0);
      data  : inout std_logic_vector(7 downto 0);
      notrw : in    std_logic;
      reset : in    std_logic
    );
  end component;

  signal mux_out    : std_logic_vector(7 downto 0);
  signal mar_out    : std_logic_vector(7 downto 0);
  signal mem_inout  : std_logic_vector(7 downto 0);
  signal mdr_out    : std_logic_vector(7 downto 0);

begin
  u_mux : mem_mux port map(pc_address, bus_address, pc_bus, mux_out);

  u_mar : mar port map(mux_out, rst, clk, mar_rw, mar_out);

  u_ram : as_ram port map(mar_out, mem_inout, mem_rw, rst);

  u_mdr : mdr port map(mem_inout, rst, clk, mdr_rw, mdr_out);

  bus_int <= mdr_out when mem_rw = '0' else (others => 'Z');

  mem_inout <= bus_int when mem_rw = '1' else (others => 'Z');

end architecture;
