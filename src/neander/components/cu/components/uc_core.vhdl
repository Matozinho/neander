library ieee;
use ieee.std_logic_1164.all;

entity uc_core is
  port(
    cl, clk  : in std_logic;
    instr    : in std_logic_vector(10 downto 0);
    nz       : in std_logic_vector(1 downto 0);
    control_bus : out std_logic_vector(10 downto 0)
  );
end entity;

architecture behavior of uc_core is

  component count07 is
    port (
      clk, cl: in std_logic;
      enable : in std_logic;
      v   : out std_logic_vector(2 downto 0)
    );
  end component;

  component nop_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component sta_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component lda_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component add_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component and_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component or_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component not_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component jmp_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component jn_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      nz      : in std_logic_vector(1 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component jz_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      nz      : in std_logic_vector(1 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  component hlt_cicle is
    port(
      cicle   : in std_logic_vector(2 downto 0);
      s       : out std_logic_vector(10 downto 0)
    );
  end component;

  signal s_nop, s_sta, s_lda, s_add, s_and, s_or, s_not, s_jmp, s_jn, s_jz, s_hlt :std_logic_vector(10 downto 0);
  signal s_cicle : std_logic_vector(2 downto 0);

begin
  u_Count : count07 port map(clk, cl, '1', s_cicle);

  u_nop : nop_cicle port map(s_cicle, s_nop);
  u_sta : sta_cicle port map(s_cicle, s_sta);
  u_lda : lda_cicle port map(s_cicle, s_lda);
  u_add : add_cicle port map(s_cicle, s_add);
  u_and : and_cicle port map(s_cicle, s_and);
  u_or  : or_cicle port map(s_cicle, s_or);
  u_not : not_cicle port map(s_cicle, s_not);
  u_jmp : jmp_cicle port map(s_cicle, s_jmp);
  u_jn  : jn_cicle port map(s_cicle, nz, s_jn);
  u_jz  : jz_cicle port map(s_cicle, nz, s_jz);
  u_hlt : hlt_cicle port map(s_cicle, s_hlt);

  control_bus <= s_nop when instr = "10000000000" else
    s_sta when instr = "01000000000" else
    s_lda when instr = "00100000000" else
    s_add when instr = "00010000000" else
    s_or  when instr = "00001000000" else
    s_and when instr = "00000100000" else
    s_not when instr = "00000010000" else
    s_jmp when instr = "00000001000" else
    s_jn  when instr = "00000000100" else
    s_jz  when instr = "00000000010" else
    s_hlt when instr = "00000000001" else
    (others => 'Z');

end architecture;
