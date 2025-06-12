library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testb_quest1 is
end testb_quest1;

architecture behavior of testb_quest1 is

    component quest1
        Port (
            CLOCK         : in  STD_LOGIC;
            RESET         : in  STD_LOGIC;
            A             : in  STD_LOGIC_VECTOR (1 downto 0);
            REFRIGERANTE  : out STD_LOGIC;
            TROCO25       : out STD_LOGIC;
            TROCO50       : out STD_LOGIC
        );
    end component;

    signal CLOCK         : STD_LOGIC := '0';
    signal RESET         : STD_LOGIC := '0';
    signal A             : STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal REFRIGERANTE  : STD_LOGIC;
    signal TROCO25       : STD_LOGIC;
    signal TROCO50       : STD_LOGIC;

    constant clk_period : time := 10 ns;

begin

    uut: quest1
        port map (
            CLOCK => CLOCK,
            RESET => RESET,
            A => A,
            REFRIGERANTE => REFRIGERANTE,
            TROCO25 => TROCO25,
            TROCO50 => TROCO50
        );

    -- Clock generation
    clk_process :process
    begin
        CLOCK <= '0';
        wait for clk_period/2;
        CLOCK <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- RESET inicial
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for 10 ns;

        -- Caso 1: Cancelar com R$0,25
        A <= "01"; -- R$0,25
        wait for clk_period;
        A <= "00";
        wait for clk_period;
        A <= "11"; -- Cancelar
        wait for clk_period;
        A <= "00";
        wait for 10 ns;

        -- Caso 2: Cancelar com R$0,50
        A <= "10"; -- R$0,50
        wait for clk_period;
        A <= "00";
        wait for clk_period;
        A <= "11"; -- Cancelar
        wait for clk_period;
        A <= "00";
        wait for 10 ns;

        -- Caso 3: Cancelar com R$0,75
        A <= "01"; -- R$0,25
        wait for clk_period;
        A <= "00";
        wait for clk_period;
        A <= "10"; -- R$0,50
        wait for clk_period;
        A <= "00";
        wait for clk_period;
        A <= "11"; -- Cancelar
        wait for clk_period;
        A <= "00";
        wait for 10 ns;

        -- Caso 4: Comprar com R$1,00 exato
        A <= "10"; -- R$0,50
        wait for clk_period;
        A <= "00";
        wait for clk_period;
        A <= "10"; -- R$0,50
        wait for clk_period;
        A <= "00";
        wait for 10 ns;

        -- Caso 5: Comprar com R$1,25 (libera refrigerante + devolve R$0,25)
        A <= "10"; -- R$0,50
        wait for clk_period;
        A <= "00";
        wait for clk_period;
        A <= "10"; -- R$0,50
        wait for clk_period;
        A <= "00";
        wait for clk_period;
        A <= "01"; -- R$0,25
        wait for clk_period;
        A <= "00";
        wait for 10 ns;

        -- Fim do teste
        wait;
    end process;

end behavior;