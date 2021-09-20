library ieee;
use ieee.std_logic_1164.all;

entity fadder is
  port(
    a, b, cin  : in  std_logic;
    s, cout    : out std_logic
  );
end entity;

architecture behavior of fadder is
begin
  s <= (a xor b) xor cin;
  cout <= (a and b) or (cin and a) or (cin and b);
end architecture;
