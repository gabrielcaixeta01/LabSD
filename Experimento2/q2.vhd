-- Universidade de Brasília
-- Aluno: Gabriel Caixeta Romero
-- Matrícula: 232036896

-- Descrição do circuito:
-- Multiplexador 4 para 1 com entradas de dados e seleção

library ieee;
use ieee.std_logic_1164.all;

-- Definição da entidade
entity q2 is
    port (
        D : in std_logic_vector(3 downto 0);
        S : in std_logic_vector(1 downto 0);
        Y : out std_logic
    );
end q2;

-- Arquitetura do circuito
architecture multiplex_arch of q2 is
begin

    -- Processo para seleção da entrada conforme S
    process (D, S)
    begin
        if S = "00" then
            Y <= D(0);
        elsif S = "01" then
            Y <= D(1);
        elsif S = "10" then
            Y <= D(2);
        elsif S = "11" then
            Y <= D(3);
        end if;
    end process;

end multiplex_arch;