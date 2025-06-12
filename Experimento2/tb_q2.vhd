-- Universidade de Brasília
-- Aluno: Gabriel Caixeta Romero
-- Matrícula: 232036896

-- Testbench para o Multiplexador 4 para 1

library ieee;
use ieee.std_logic_1164.all;

entity tb_q2 is
end tb_q2;

architecture tb_multiplex_arch of tb_q2 is

    -- Declaração do componente q2
    component q2
        port (
            D : in std_logic_vector(3 downto 0);
            S : in std_logic_vector(1 downto 0);
            Y : out std_logic
        );
    end component;

    -- Sinais auxiliares para teste
    signal sig_D : std_logic_vector(3 downto 0);
    signal sig_S : std_logic_vector(1 downto 0);
    signal sig_Y : std_logic;

begin

    -- Instância do componente em teste
    mux_inst : q2
        port map (
            D => sig_D,
            S => sig_S,
            Y => sig_Y
        );

    -- Processo de estímulo para testar o multiplexador
    stim_proc : process
    begin
        -- Teste com D = "0001" (D0 ativo)
        sig_D <= "0001";
        sig_S <= "00";
        wait for 5 ns;
        sig_S <= "01";
        wait for 5 ns;
        sig_S <= "10";
        wait for 5 ns;
        sig_S <= "11";
        wait for 5 ns;

        -- Teste com D = "0010" (D1 ativo)
        sig_D <= "0010";
        sig_S <= "00";
        wait for 5 ns;
        sig_S <= "01";
        wait for 5 ns;
        sig_S <= "10";
        wait for 5 ns;
        sig_S <= "11";
        wait for 5 ns;

        -- Teste com D = "0100" (D2 ativo)
        sig_D <= "0100";
        sig_S <= "00";
        wait for 5 ns;
        sig_S <= "01";
        wait for 5 ns;
        sig_S <= "10";
        wait for 5 ns;
        sig_S <= "11";
        wait for 5 ns;

        -- Teste com D = "1000" (D3 ativo)
        sig_D <= "1000";
        sig_S <= "00";
        wait for 5 ns;
        sig_S <= "01";
        wait for 5 ns;
        sig_S <= "10";
        wait for 5 ns;
        sig_S <= "11";
        wait for 5 ns;

        -- Finaliza simulação
        wait;
    end process;

end tb_multiplex_arch;