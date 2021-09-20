library ieee;
use ieee.std_logic_1164.all;

entity add_cicle is
  port(
    cicle   : in std_logic_vector(2 downto 0);
    s       : out std_logic_vector(10 downto 0)
  );
end entity;

architecture behavior of add_cicle is
begin
  -- ¬BarInc
  s(10) <= '1';

  -- ¬BarPC
  s(9) <= cicle(1) or not cicle(2) or not cicle(0);

  -- ULAOp
  s(8) <= '0';
  s(7) <= '0';
  s(6) <= '1';

  -- pc_rw
  s(5) <= not cicle(1) and (cicle(0) xor cicle(2));

  -- ACrw
  s(4) <= cicle(0) and cicle(1) and cicle(2);

  -- MEMrw
  s(3) <= '0';

  -- REMrw
  s(2) <=  (not cicle(1) and (cicle(2) xnor cicle(0))) or (cicle(0) and cicle(1) and not cicle(2));

  -- RDMrw
  s(1) <= (not cicle(0) and cicle(2)) or (not cicle(1) and cicle(0) and not cicle(2));

  -- RIrw
  s(0) <= cicle(1) and not cicle(0) and not cicle(2);

end architecture;
