-- clock24.vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity clock24 is
    port (
        clk       : in  std_logic;  -- 1 Hz clock
        reset_n   : in  std_logic;  -- ativo em '0'
        h_tens    : out std_logic_vector(1 downto 0); -- 0..2
        h_units   : out std_logic_vector(3 downto 0); -- 0..9
        m_tens    : out std_logic_vector(2 downto 0); -- 0..5
        m_units   : out std_logic_vector(3 downto 0); -- 0..9
        s_tens    : out std_logic_vector(2 downto 0); -- 0..5
        s_units   : out std_logic_vector(3 downto 0)  -- 0..9
    );
end entity;
 
architecture rtl of clock24 is
    signal su, st : unsigned(3 downto 0);
    signal mu, mt : unsigned(3 downto 0);
    signal hu, ht : unsigned(3 downto 0);
 
    signal carry_su  : std_logic;
    signal carry_st  : std_logic;
    signal carry_mu  : std_logic;
    signal carry_mt  : std_logic;
    signal carry_hu  : std_logic;
begin
 
  -- Seconds‑units (0..9)
  proc_su: process(clk, reset_n)
  begin
    if reset_n = '0' then
      su        <= (others => '0');
      carry_su  <= '0';
    elsif rising_edge(clk) then
      if su = 9 then
        su       <= (others => '0');
        carry_su <= '1';
      else
        su       <= su + 1;
        carry_su <= '0';
      end if;
    end if;
  end process;
 
  -- Seconds‑tens (0..5)
  proc_st: process(clk, reset_n)
  begin
    if reset_n = '0' then
      st        <= (others => '0');
      carry_st  <= '0';
    elsif rising_edge(clk) then
      if carry_su = '1' then
        if st = 5 then
          st       <= (others => '0');
          carry_st <= '1';
        else
          st       <= st + 1;
          carry_st <= '0';
        end if;
      else
        carry_st <= '0';
      end if;
    end if;
  end process;
 
  -- Minutes‑units (0..9)
  proc_mu: process(clk, reset_n)
  begin
    if reset_n = '0' then
      mu        <= (others => '0');
      carry_mu  <= '0';
    elsif rising_edge(clk) then
      if carry_st = '1' then
        if mu = 9 then
          mu       <= (others => '0');
          carry_mu <= '1';
        else
          mu       <= mu + 1;
          carry_mu <= '0';
        end if;
      else
        carry_mu <= '0';
      end if;
    end if;
  end process;
 
  -- Minutes‑tens (0..5)
  proc_mt: process(clk, reset_n)
  begin
    if reset_n = '0' then
      mt        <= (others => '0');
      carry_mt  <= '0';
    elsif rising_edge(clk) then
      if carry_mu = '1' then
        if mt = 5 then
          mt       <= (others => '0');
          carry_mt <= '1';
        else
          mt       <= mt + 1;
          carry_mt <= '0';
        end if;
      else
        carry_mt <= '0';
      end if;
    end if;
  end process;
 
  -- Hours‑units (0..9, mas limitado a 3 quando tens=2)
  proc_hu: process(clk, reset_n)
  begin
    if reset_n = '0' then
      hu       <= (others => '0');
      carry_hu <= '0';
    elsif rising_edge(clk) then
      if carry_mt = '1' then
        if (ht = 2 and hu = 3) or hu = 9 then
          hu       <= (others => '0');
          carry_hu <= '1';
        else
          hu       <= hu + 1;
          carry_hu <= '0';
        end if;
      else
        carry_hu <= '0';
      end if;
    end if;
  end process;
 
  -- Hours‑tens (0..2)
  proc_ht: process(clk, reset_n)
  begin
    if reset_n = '0' then
      ht <= (others => '0');
    elsif rising_edge(clk) then
      if carry_hu = '1' then
        if ht = 2 then
          ht <= (others => '0');
        else
          ht <= ht + 1;
        end if;
      end if;
    end if;
  end process;
 
  -- Map to outputs (truncating to the needed width)
  s_units  <= std_logic_vector(su);
  s_tens   <= std_logic_vector(st(2 downto 0));
  m_units  <= std_logic_vector(mu);
  m_tens   <= std_logic_vector(mt(2 downto 0));
  h_units  <= std_logic_vector(hu);
  h_tens   <= std_logic_vector(ht(1 downto 0));
 
end architecture;