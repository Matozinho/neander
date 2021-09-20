library ieee;
use ieee.std_logic_1164.all;

entity decoder is
  port(
    instruction_in  : in std_logic_vector(7 downto 0);
    instruction_out : out std_logic_vector(10 downto 0)
  );
end entity;

architecture behavior of decoder is
begin
  instruction_out(10) <= (((not instruction_in(7) and not instruction_in(6)) and not instruction_in(5)) and not instruction_in(4));
  instruction_out(9) <= (((not instruction_in(7) and not instruction_in(6)) and not instruction_in(5)) and instruction_in(4));
  instruction_out(8) <= (((not instruction_in(7) and not instruction_in(6)) and instruction_in(5)) and not instruction_in(4));
  instruction_out(7) <= (((not instruction_in(7) and not instruction_in(6)) and instruction_in(5)) and instruction_in(4));
  instruction_out(6) <= (((not instruction_in(7) and instruction_in(6)) and not instruction_in(5)) and not instruction_in(4));
  instruction_out(5) <= (((not instruction_in(7) and instruction_in(6)) and not instruction_in(5)) and instruction_in(4));
  instruction_out(4) <= (((not instruction_in(7) and instruction_in(6)) and instruction_in(5)) and not instruction_in(4));
  instruction_out(3) <= (((instruction_in(7) and not instruction_in(6)) and not instruction_in(5)) and not instruction_in(4));
  instruction_out(2) <= (((instruction_in(7) and not instruction_in(6)) and not instruction_in(5)) and instruction_in(4));
  instruction_out(1) <= (((instruction_in(7) and not instruction_in(6)) and instruction_in(5)) and not instruction_in(4));
  instruction_out(0) <= (((instruction_in(7) and instruction_in(6)) and instruction_in(5)) and instruction_in(4));

end architecture;
