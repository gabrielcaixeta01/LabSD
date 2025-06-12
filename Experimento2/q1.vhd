-- Universidade de Brasília
-- Aluno: Gabriel Caixeta Romero
-- Matrícula: 232036896

-- Descrição do circuito:
-- Somador Completo com três bits de entrada e duas saídas

library ieee;
use ieee.std_logic_1164.all;

-- Definição da entidade
entity q1 is
    port (
        A    : in std_logic;
        B    : in std_logic;
        Cin  : in std_logic;
        S    : out std_logic;
        Cout : out std_logic
    );
end q1;

-- Arquitetura do circuito
architecture behavior of q1 is
begin
    -- Operação da soma
    S <= A xor B xor Cin;

    -- Operação do transporte (carry-out)
    Cout <= (A and B) or (A and Cin) or (B and Cin);
end behavior;