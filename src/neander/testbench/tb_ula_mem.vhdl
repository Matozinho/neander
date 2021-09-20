library ieee;
use ieee.std_logic_1164.all;

entity tbULA_MEM is
  port(
    rst, clk  : in std_logic
  );
end entity;

architecture behavior of tbULA_MEM is
  constant ciclo_clock : time := 20 ns;

  component ULA is
    port(
      rst, clk  : in std_logic;
      memData   : inout std_logic_vector(7 downto 0);
      ULAOp     : in std_logic_vector(2 downto 0);
      ACrw      : in std_logic;
      MEMrw     : in std_logic;
      flags     : out std_logic_vector(1 downto 0)
    );
  end component;

  component MEM is
    port(
      rst, clk  : in std_logic;
      endPC     : in std_logic_vector(7 downto 0);
      endBar    : in std_logic_vector(7 downto 0);
      nBarPC    : in std_logic;
      REMrw     : in std_logic;
      MEMrw     : in std_logic;
      RDMrw     : in std_logic;
      intBar    : inout std_logic_vector(7 downto 0)
    );
  end component;

  signal srst : std_logic := '1';
  signal sclk : std_logic := '0';


  signal sBarramento            : std_logic_vector(7 downto 0);
  signal sEndPC                 : std_logic_vector(7 downto 0) := (others => '0');
  signal sACrw, sREMrw, sRDMrw  : std_logic;
  signal sNBarPC, sMEMrw        : std_logic;
  signal sUlaOP                 : std_logic_vector(2 downto 0);

begin
  sclk <= not(sclk) after ciclo_clock / 2;

  u_ULA : ULA port map(srst, sclk, sBarramento, sUlaOP, sACrw, sMEMrw);

  u_MEM : MEM port map(srst, sclk, sEndPC, sBarramento, sNBarPC, sREMrw, sMEMrw, sRDMrw, sBarramento);

  tB : process
  begin
    -- reset inicial
    srst <= '0';
    wait for ciclo_clock;
    srst <= '1';

    -- Reset de sinais
    sUlaOP <= "000";
    sACrw <= '0';
    sRDMrw <= '0';

    -- Sinais da memória
    sNBarPC <= '1';
    sREMrw <= '1';
    sMEMrw <= '0';

    wait for ciclo_clock;

    sRDMrw <= '1';

    wait for ciclo_clock;
    sRDMrw <= '0';
    -- Sinais da ULA - LDA
    sACrw <= '1';
    sUlaOP <= "000";

    wait for ciclo_clock;

    -- Dado do PC
    sEndPC <= "00000000";
    --wait for ciclo_clock;

    --Sinais ULA - ADD
    sUlaOP <= "001";
    wait for ciclo_clock;

    -- Mover dado AC para memória
    sREMrw <= '0';
    sRDMrw <= '0';

    sACrw <= '0';
    sMEMrw <= '1';
    sNBarPC <= '0';
    wait for ciclo_clock;

    sMEMrw <= '0';
    wait for ciclo_clock;

    wait;
  end process;
end architecture;
