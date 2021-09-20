library ieee;
use ieee.std_logic_1164.all;

entity control_ffjk7 is
  port(
    ea   : in  std_logic_vector(2 downto 0);
    j, k : out std_logic_vector(2 downto 0)
  );
end entity;

architecture control of control_ffjk7 is

begin

  j(2) <= ea(1) and ea(0);
  k(2) <= ea(1) and ea(0);

  j(1) <= ea(0);
  k(1) <= ea(0);

  j(0) <= '1';
  k(0) <= '1';

end architecture;
