-- Universidade de Brasília
-- Aluno: Gabriel Caixeta Romero
-- Matrícula: 232036896

-- Testbench para o Somador Completo

library ieee;
use ieee.std_logic_1164.all;

-- Entidade do testbench (sem portas, pois é só simulação)
entity tb_q1 is
end tb_q1;

-- Arquitetura do testbench
architecture behavior of tb_q1 is

    -- Componente a ser testado
    component q1
        port (
            A    : in std_logic;
            B    : in std_logic;
            Cin  : in std_logic;
            S    : out std_logic;
            Cout : out std_logic
        );
    end component;

    -- Sinais auxiliares para interconexão
    signal A    : std_logic := '0';
    signal B    : std_logic := '0';
    signal Cin  : std_logic := '0';
    signal S    : std_logic;
    signal Cout : std_logic;

begin

    -- Instância do componente
    uut: q1 port map (
        A    => A,
        B    => B,
        Cin  => Cin,
        S    => S,
        Cout => Cout
    );

    -- Processo de estímulo (testes)
    stim_proc: process
    begin
        -- Teste 1
        A <= '0'; B <= '0'; Cin <= '0';
        wait for 5 ns;

        -- Teste 2
        A <= '0'; B <= '0'; Cin <= '1';
        wait for 5 ns;

        -- Teste 3
        A <= '0'; B <= '1'; Cin <= '0';
        wait for 5 ns;

        -- Teste 4
        A <= '0'; B <= '1'; Cin <= '1';
        wait for 5 ns;

        -- Teste 5
        A <= '1'; B <= '0'; Cin <= '0';
        wait for 5 ns;

        -- Teste 6
        A <= '1'; B <= '0'; Cin <= '1';
        wait for 5 ns;

        -- Teste 7
        A <= '1'; B <= '1'; Cin <= '0';
        wait for 5 ns;

        -- Teste 8
        A <= '1'; B <= '1'; Cin <= '1';
        wait for 5 ns;

        -- Finaliza simulação
        wait;
    end process;

end behavior;