library ieee;
use ieee.std_logic_1164.all;

entity alu is
  port(
    rst, clk  : in std_logic;
    mem_data   : inout std_logic_vector(7 downto 0);
    alu_op     : in std_logic_vector(2 downto 0);
    ac_rw      : in std_logic;
    mem_rw     : in std_logic;
    flags_out     : out std_logic_vector(1 downto 0)
  );
end entity;

architecture behavior of alu is
  component core is
    port(
      mem_data   : in std_logic_vector(7 downto 0);
      ac_data   : in std_logic_vector(7 downto 0);
      operation : in std_logic_vector(2 downto 0);
      s         : out std_logic_vector(7 downto 0);
      nz        : out std_logic_vector(1 downto 0)
    );
  end component;

  component alu_mux is
    port(
      mem_data : in std_logic_vector(7 downto 0);
      ac_data : in std_logic_vector(7 downto 0);
      mem_rw   : in std_logic;
      s       : out std_logic_vector(7 downto 0)
    );
  end component;

  component ac is
    port(
      din     : in std_logic_vector(7 downto 0);
      cl, clk : in std_logic;
      ac_rw    : in std_logic;
      dout    : out std_logic_vector(7 downto 0)
    );
  end component;

  component flags is
    port(
      din     : in std_logic_vector(1 downto 0);
      cl, clk : in std_logic;
      ac_rw    : in std_logic;
      dout    : out std_logic_vector(1 downto 0)
    );
  end component;

  signal ac_out :  std_logic_vector(7 downto 0);
  signal core_out : std_logic_vector(7 downto 0);
  signal snz : std_logic_vector(1 downto 0);

begin
  u_ac : ac port map(core_out, rst, clk, ac_rw, ac_out);
  u_core : core port map(mem_data, ac_out, alu_op, core_out, snz);
  u_flags : flags port map(snz, rst, clk, ac_rw, flags_out);
  mem_data <= ac_out when mem_rw='1' else (others => 'Z');
end architecture;
