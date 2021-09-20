library ieee;
use ieee.std_logic_1164.all;

entity core is
  port(
    mem_data   : in std_logic_vector(7 downto 0);
    ac_data   : in std_logic_vector(7 downto 0);
    operation : in std_logic_vector(2 downto 0);
    s         : out std_logic_vector(7 downto 0);
    nz        : out std_logic_vector(1 downto 0)
  );
end entity;

architecture behavior of core is

  component fadder8 is
    port(
      a, b : in  std_logic_vector(7 downto 0);
      cin  : in  std_logic;
      s    : out std_logic_vector(7 downto 0);
      cout : out std_logic
    );
  end component;

  signal not_op, and_op, or_op, add_op: std_logic_vector(7 downto 0);
  signal s_s : std_logic_vector(7 downto 0);

begin
  u_adder : fadder8 port map(ac_data, mem_data, '0', add_op);

  not_op <= not ac_data;
  and_op <= ac_data and mem_data;
  or_op <= ac_data or mem_data;

  s_s <= not_op when operation = "100" else
    and_op when operation = "011" else
    or_op when operation = "010" else
    add_op when operation = "001" else mem_data;

  nz <= "10" when s_s(7) = '1' else
    "01" when (s_s = "00000000") else "00";

  s <= s_s;

end architecture;
