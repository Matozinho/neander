library ieee;
use ieee.std_logic_1164.all;

entity hlt_cicle is
  port(
    cicle   : in std_logic_vector(2 downto 0);
    s       : out std_logic_vector(10 downto 0)
  );
end entity;

architecture behavior of hlt_cicle is
begin
  -- ¬BarInc
  s(10) <= '0';

  -- not BarPC
  s(9) <= '0';

  -- ULAOp
  s(8) <= '0';
  s(7) <= '0';
  s(6) <= '0';

  -- pc_rw
  s(5) <= '0';

  -- ACrw
  s(4) <= '0';

  -- MEMrw
  s(3) <= '0';

  -- REMrw
  s(2) <= '0';

  -- RDMrw
  s(1) <= '0';

  -- RIrw
  s(0) <= '0';

end architecture;
