library ieee;
use ieee.std_logic_1164.all;

entity pc_mux is
  port(
    bus_i    : in std_logic_vector(7 downto 0);
    inc     : in std_logic_vector(7 downto 0);
    bus_inc : in std_logic;
    s       : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behavior of pc_mux is

begin
  s <= inc when bus_inc = '1' else bus_i;
end architecture;
