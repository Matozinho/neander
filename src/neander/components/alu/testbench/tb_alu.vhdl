library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end entity;

architecture behavior of tb_alu is
  constant ciclo_clock : time := 20 ns;

  component alu is
    port(
      rst, clk  : in std_logic;
      mem_data   : inout std_logic_vector(7 downto 0);
      alu_op     : in std_logic_vector(2 downto 0);
      ac_rw      : in std_logic;
      mem_rw     : in std_logic;
      flags     : out std_logic_vector(1 downto 0)
    );
  end component;

  signal srst : std_logic := '1';
  signal sclk : std_logic := '0';
  signal s_mem_data : std_logic_vector(7 downto 0);
  signal s_op : std_logic_vector(2 downto 0);
  signal sac_rw, smem_rw : std_logic;
  signal s_flags : std_logic_vector(1 downto 0);

begin
  sclk <= not(sclk) after ciclo_clock / 2;

  u_alu : alu port map(srst, sclk, s_mem_data, s_op, sac_rw, smem_rw, s_flags);

  tb : process
  begin
    -- reset inicial
    srst <= '0';
    wait for ciclo_clock;
    srst <= '1';

    -- LDA
    s_op <= "000";
    sac_rw <= '1';
    smem_rw <= '0';
    s_mem_data <= "01010100";
    wait for ciclo_clock; -- t

    -- ADD
    s_op <= "001";
    s_mem_data <= "00000001";
    wait for ciclo_clock; -- t

    -- OR
    s_op <= "010";
    s_mem_data <= "00000010";
    wait for ciclo_clock; -- t

    -- AND
    s_op <= "011";
    s_mem_data <= "01010100";
    wait for ciclo_clock; -- t

    -- not
    s_op <= "100";
    wait for ciclo_clock; -- t

    -- flags
    s_op <= "011";
    s_mem_data <= "00000000";

    wait; -- forever!
  end process;
end architecture;
