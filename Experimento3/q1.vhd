-- Universidade de Brasília
-- Aluno: Gabriel Caixeta Romero
-- Matrícula: 232036896
-- Circuito: Multiplexador 8x1 com entrada de habilitação

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Q_1 is
    port (
        D : in std_logic_vector(7 downto 0);  -- Dados de entrada
        B : in std_logic;                     -- Sinal de habilitação
        S : in std_logic_vector(2 downto 0);  -- Seletor
        Y : out std_logic                     -- Saída
    );
end Q_1;

architecture mux_arch of Q_1 is
begin
    Y <= D(to_integer(unsigned(S))) when (B = '0') else '0';
end mux_arch;