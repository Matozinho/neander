library ieee;
use ieee.std_logic_1164.all;

entity ir is
  port(
    din     : in std_logic_vector(7 downto 0);
    cl, clk : in std_logic;
    RIrw    : in std_logic;
    dout    : out std_logic_vector(7 downto 0)
  );
end entity;

architecture storage of ir is
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

  reg : for i in 7 downto 0 generate
    r : ffd port map(din(i), clk, '1', cl, RIrw, dout(i));
  end generate reg;

end architecture;
