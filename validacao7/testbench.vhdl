library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity tb_q1_exp7_50c is
end entity;
 
architecture behavioral of tb_q1_exp7_50c is
    component q1_exp7_50c is
        port (
            A        : in  std_logic_vector(1 downto 0);
            clock    : in  std_logic;
            reset    : in  std_logic;
            Refri    : out std_logic;
            troco_50 : out std_logic
        );
    end component;
 
    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '0';
    signal A_tb      : std_logic_vector(1 downto 0) := "00";
    signal Refri_sig : std_logic;
    signal troco_sig : std_logic;
 
    constant CLK_PERIOD : time := 10 ns;
begin
    UUT: q1_exp7_50c port map(
        A        => A_tb,
        clock    => clk_tb,
        reset    => rst_tb,
        Refri    => Refri_sig,
        troco_50 => troco_sig
    );
 
    clk_proc: process
    begin
        while true loop
            clk_tb <= '0'; wait for CLK_PERIOD/2;
            clk_tb <= '1'; wait for CLK_PERIOD/2;
        end loop;
    end process;
 
    stim_proc: process
    begin
        -- Reset inicial
        rst_tb <= '1'; A_tb <= "00";
        wait for 2*CLK_PERIOD;
        rst_tb <= '0'; wait for CLK_PERIOD;
 
        -- 1) Inserir 50c (Init -> S50)
        A_tb <= "10"; wait for CLK_PERIOD;
        A_tb <= "00"; wait for CLK_PERIOD;
 
        -- 2) Segunda 50c (S50 -> S100): Refri=1
        A_tb <= "10"; wait for CLK_PERIOD;
        wait for CLK_PERIOD;
        assert Refri_sig = '1' report "Falha: Refri nao ativado em S100" severity error;
        A_tb <= "00"; wait for CLK_PERIOD;
 
        -- 3) Terceira 50c (Init->S50->S100->S150): Refri=1 e troco=1
        A_tb <= "10"; wait for CLK_PERIOD; -- vai a S50
        A_tb <= "10"; wait for CLK_PERIOD; -- vai a S100
        A_tb <= "10"; wait for CLK_PERIOD; -- vai a S150
        wait for CLK_PERIOD;
        assert Refri_sig = '1' and troco_sig = '1' report "Falha: S150 incorreto" severity error;
        A_tb <= "00"; wait for CLK_PERIOD;
 
        -- 4) Cancelar em Init (sem troco)
        A_tb <= "11"; wait for CLK_PERIOD;
        A_tb <= "00"; wait for CLK_PERIOD;
 
        -- 5) Inserir 50c e cancelar (S50->D50): troco=1
        A_tb <= "10"; wait for CLK_PERIOD;
        A_tb <= "11"; wait for CLK_PERIOD;
        wait for CLK_PERIOD;
        assert troco_sig = '1' report "Falha: D50 nao ativado" severity error;
        A_tb <= "00"; wait for CLK_PERIOD;
 
        -- 6) Reset em S100
        A_tb <= "10"; wait for CLK_PERIOD;
        A_tb <= "10"; wait for CLK_PERIOD;
        rst_tb <= '1'; wait for CLK_PERIOD;
        rst_tb <= '0'; A_tb <= "00"; wait for CLK_PERIOD;
 
        -- Fim da simulação
        wait for 5*CLK_PERIOD;
        std.env.stop;
        wait;
    end process;
end architecture;