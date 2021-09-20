library ieee;
use ieee.std_logic_1164.all;

entity count07 is
  port (
    clk, cl: in std_logic;
    enable : in std_logic;
    v   : out std_logic_vector(2 downto 0)
  );
end entity;

architecture count of count07 is

  component ffjk is
    port(
      j, k   : in std_logic;
      clk    : in std_logic;
      pr, cl : in std_logic;
      q, nq  : out std_logic
    );
  end component;

  component control_ffjk7 is
    port(
      ea   : in  std_logic_vector(2 downto 0);
      j, k : out std_logic_vector(2 downto 0)
    );
  end component;

  signal sv : std_logic_vector(2 downto 0);
  signal sj, sk : std_logic_vector(2 downto 0);
  signal ssj, ssk : std_logic_vector(2 downto 0);

begin

  v <= sv;

  gen: for i in 0 to 2 generate
    ff: ffjk port map(sj(i), sk(i), clk, '1', cl, sv(i));

    sj(i) <= ssj(i) when enable = '1' else '0';
    sk(i) <= ssk(i) when enable = '1' else '0';
  end generate gen;

  u_control_ffjk7 : control_ffjk7 port map(sv, ssj, ssk);

end architecture;
