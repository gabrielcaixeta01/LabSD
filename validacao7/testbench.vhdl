library ieee;
use ieee.std_logic_1164.all;

entity tb_refri is
end entity;

architecture tb of tb_refri is
    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';
    signal A1    : std_logic := '0';
    signal A0    : std_logic := '0';
    signal Q1    : std_logic;
    signal Q0    : std_logic;

    component refri
        port (
            clk   : in std_logic;
            reset : in std_logic;
            A1    : in std_logic;
            A0    : in std_logic;
            Q1    : out std_logic;
            Q0    : out std_logic
        );
    end component;

begin

    uut: refri
        port map (
            clk   => clk,
            reset => reset,
            A1    => A1,
            A0    => A0,
            Q1    => Q1,
            Q0    => Q0
        );

    -- Clock process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Reset
        wait for 10 ns;
        reset <= '0';

        -- Idle → e50c (entrada de 50c)
        A1 <= '0'; A0 <= '1'; wait for 10 ns;

        -- e50c → e100c (mais 50c)
        A1 <= '0'; A0 <= '1'; wait for 10 ns;

        -- e100c → Idle (entrada inválida: A1='1', A0='0')
        A1 <= '1'; A0 <= '0'; wait for 10 ns;

        -- Idle → e50c (nova tentativa)
        A1 <= '0'; A0 <= '1'; wait for 10 ns;

        -- e50c → d50c (inserção de 1 real)
        A1 <= '1'; A0 <= '1'; wait for 10 ns;

        -- d50c → e50c (entrada de 50c)
        A1 <= '0'; A0 <= '1'; wait for 10 ns;

        -- e50c → e50c (entrada inválida: A1='0', A0='0')
        A1 <= '0'; A0 <= '0'; wait for 10 ns;

        -- e50c → d50c (entrada de 1 real)
        A1 <= '1'; A0 <= '1'; wait for 10 ns;

        -- d50c → Idle (entrada inválida: A1='1', A0='0')
        A1 <= '1'; A0 <= '0'; wait for 10 ns;

        -- Fim da simulação
        wait for 20 ns;
        assert false report "Fim da simulação." severity note;
        wait;
    end process;

end architecture;