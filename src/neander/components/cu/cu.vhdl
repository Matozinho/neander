library ieee;
use ieee.std_logic_1164.all;

entity cu is
  port(
    cl, clk     : in std_logic;
    nz          : in std_logic_vector(1 downto 0);
    data_bus   : inout std_logic_vector(7 downto 0);
    pc_out       : out std_logic_vector(7 downto 0);
    control_bus    : out std_logic_vector(10 downto 0)
  );
end entity;

architecture behavior of cu is

  component decoder is
    port(
      instruction_in  : in std_logic_vector(7 downto 0);
      instruction_out : out std_logic_vector(10 downto 0)
    );
  end component;

  component pc is
    port(
      cl, clk : in std_logic;
      bus_i    : in std_logic_vector(7 downto 0);
      bus_inc : in std_logic;
      pc_rw    : in std_logic;
      address_out  : out std_logic_vector(7 downto 0)
    );
  end component;

  component ir is
    port(
      din     : in std_logic_vector(7 downto 0);
      cl, clk : in std_logic;
      RIrw    : in std_logic;
      dout    : out std_logic_vector(7 downto 0)
    );
  end component;

  component uc_core is
    port(
      cl, clk  : in std_logic;
      instr    : in std_logic_vector(10 downto 0);
      nz       : in std_logic_vector(1 downto 0);
      control_bus : out std_logic_vector(10 downto 0)
    );
  end component;

  signal ir_decode : std_logic_vector(7 downto 0);
  signal decode_core, core_control : std_logic_vector(10 downto 0);

begin

  u_pc      : pc port map(cl, clk, data_bus, core_control(10), core_control(5), pc_out);
  u_ir      : ir port map(data_bus, cl, clk, core_control(0), ir_decode);
  u_decoder : decoder port map(ir_decode, decode_core);
  u_core    : uc_core port map(cl, clk, decode_core, nz, core_control);

  control_bus <= core_control;
end architecture;
