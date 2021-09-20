library ieee;
use ieee.std_logic_1164.all;

entity fadder8 is
  port(
    a, b : in  std_logic_vector(7 downto 0);
    cin  : in  std_logic;
    s    : out std_logic_vector(7 downto 0);
    cout : out std_logic
  );
end entity;

architecture behavior of fadder8 is
  component fadder is
    port(
      a, b, cin  : in  std_logic;
      s, cout    : out std_logic
    );
  end component;

  signal c1, c2, c3, c4, c5, c6, c7, c8 : std_logic;
begin
  u_fadder0 : fadder port map(a(0), b(0), cin, s(0), c1);
  u_fadder1 : fadder port map(a(1), b(1), c1,  s(1), c2);
  u_fadder2 : fadder port map(a(2), b(2), c2,  s(2), c3);
  u_fadder3 : fadder port map(a(3), b(3), c3,  s(3), c4);
  u_fadder4 : fadder port map(a(4), b(4), c4,  s(4), c5);
  u_fadder5 : fadder port map(a(5), b(5), c5,  s(5), c6);
  u_fadder6 : fadder port map(a(6), b(6), c6,  s(6), c7);
  u_fadder7 : fadder port map(a(7), b(7), c7,  s(7), c8);

  cout <= c8;
end architecture;
