library ieee;
use ieee.std_logic_1164.all;

entity flags is
  port(
    din     : in std_logic_vector(1 downto 0);
    cl, clk : in std_logic;
    ac_rw    : in std_logic;
    dout    : out std_logic_vector(1 downto 0)
  );
end entity;

architecture storage of flags is
  component ffd is
    port(
      d      : in std_logic;
      clk    : in std_logic;
      pr, cl : in std_logic;
      nrw    : in std_logic;
      q, nq  : out std_logic
    );
  end component;

begin
  n : ffd port map(din(1), clk, '1', cl, ac_rw, dout(1));
  z : ffd port map(din(0), clk, cl, '1', ac_rw, dout(0));
end architecture;
