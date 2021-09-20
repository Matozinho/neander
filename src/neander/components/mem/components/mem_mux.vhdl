library ieee;
use ieee.std_logic_1164.all;

entity mem_mux is
  port(
    pc_address   : in std_logic_vector(7 downto 0);
    bus_address  : in std_logic_vector(7 downto 0);
    pc_bus  : in std_logic;
    s       : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behavior of mem_mux is

begin

  s <= pc_address when pc_bus = '1' else bus_address;

end architecture;
