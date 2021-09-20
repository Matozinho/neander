library ieee;
use ieee.std_logic_1164.all;

entity alu_mux is
  port(
    mem_data : in std_logic_vector(7 downto 0);
    ac_data : in std_logic_vector(7 downto 0);
    mem_rw   : in std_logic;
    s       : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behavior of alu_mux is

begin
  s <= ac_data when mem_rw='1' else (others => 'Z');
end architecture;
