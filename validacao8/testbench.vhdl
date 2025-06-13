-- tb_clock24.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;
 
entity tb_clock24 is
end entity;
 
architecture sim of tb_clock24 is
 
  -- componentes
  component clock24 is
    port (
      clk       : in  std_logic;
      reset_n   : in  std_logic;
      h_tens    : out std_logic_vector(1 downto 0);  -- 2 bits
      h_units   : out std_logic_vector(3 downto 0);  -- 4 bits
      m_tens    : out std_logic_vector(2 downto 0);  -- 3 bits
      m_units   : out std_logic_vector(3 downto 0);
      s_tens    : out std_logic_vector(2 downto 0);
      s_units   : out std_logic_vector(3 downto 0)
    );
  end component;
 
  -- sinais com a largura EXATA de cada dígito
  signal clk     : std_logic := '0';
  signal reset_n : std_logic := '0';
  signal h_tens  : std_logic_vector(1 downto 0);
  signal h_units : std_logic_vector(3 downto 0);
  signal m_tens  : std_logic_vector(2 downto 0);
  signal m_units : std_logic_vector(3 downto 0);
  signal s_tens  : std_logic_vector(2 downto 0);
  signal s_units : std_logic_vector(3 downto 0);
 
  constant CLK_PERIOD : time := 10 ns;  -- 1 Hz simulada
 
begin
 
  UUT: clock24
    port map (
      clk     => clk,
      reset_n => reset_n,
      h_tens  => h_tens,
      h_units => h_units,
      m_tens  => m_tens,
      m_units => m_units,
      s_tens  => s_tens,
      s_units => s_units
    );
 
  -- gera clock 1 Hz
  clk_proc: process
  begin
    clk <= '0';
    wait for CLK_PERIOD/2;
    clk <= '1';
    wait for CLK_PERIOD/2;
  end process;
 
  -- estímulo e impressão
  stim_proc: process
    variable L : line;
  begin
    -- reset ativo por 25 ns
    reset_n <= '0';
    wait for 25 ns;
    reset_n <= '1';
 
    wait;  -- para a simulação
  end process;
 
end architecture;