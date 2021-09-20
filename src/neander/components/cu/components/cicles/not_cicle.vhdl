library ieee;
use ieee.std_logic_1164.all;

entity not_cicle is
  port(
    cicle   : in std_logic_vector(2 downto 0);
    s       : out std_logic_vector(10 downto 0)
  );
end entity;

architecture behavior of not_cicle is
begin
  -- ¬BarInc
  s(10) <= '1';

  -- ¬BarPC
  s(9) <= '1';

  -- ULAOp
  s(8) <= '1';
  s(7) <= '0';
  s(6) <= '0';

  -- pc_rw
  s(5) <= not cicle(1) and cicle(0) and not cicle(2);

  -- ACrw
  s(4) <= cicle(0) and cicle(1) and cicle(2);

  -- MEMrw
  s(3) <= '0';

  -- REMrw
  s(2) <= not cicle(0) and not cicle(1) and not cicle(2);

  -- RDMrw
  s(1) <= cicle(0) and not cicle(1) and not cicle(2);

  -- RIrw
  s(0) <= not cicle(0) and cicle(1) and not cicle(2);

end architecture;
