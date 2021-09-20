library ieee;
use ieee.std_logic_1164.all;

entity jn_cicle is
  port(
    cicle   : in std_logic_vector(2 downto 0);
    nz      : in std_logic_vector(1 downto 0);
    s       : out std_logic_vector(10 downto 0)
  );
end entity;

architecture behavior of jn_cicle is

  component jmp_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  signal  jmpTrue, jmpFalse : std_logic_vector(10 downto 0);
begin

  u_jmp : jmp_cicle port map(cicle, jmpTrue);

    -- ¬BarInc
  jmpFalse(10) <= '1';

  -- not BarPC
  jmpFalse(9) <= '1';

  -- ULAOp
  jmpFalse(8) <= '0';
  jmpFalse(7) <= '0';
  jmpFalse(6) <= '0';

  -- pc_rw
  jmpFalse(5) <= cicle(0) and not cicle(2);

  -- ACrw
  jmpFalse(4) <= '0';

  -- MEMrw
  jmpFalse(3) <= '0';

  -- REMrw
  jmpFalse(2) <= not cicle(0) and not cicle(1) and not cicle(2);

  -- RDMrw
  jmpFalse(1) <= cicle(0) and not cicle(1) and not cicle(2);

  -- RIrw
  jmpFalse(0) <= cicle(1) and not cicle(0) and not cicle(2);

  s <= jmpTrue when nz(1) = '1' else jmpFalse;

end architecture;
