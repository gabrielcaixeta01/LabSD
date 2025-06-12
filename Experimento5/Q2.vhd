library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- Entity (Entidade)
-- Pinos de Entrada e Saída
entity Q2 is
    port (
        A : in  std_logic_vector(3 downto 0);
        B : in  std_logic_vector(3 downto 0);
        S : out std_logic_vector(4 downto 0)
    );
end Q2;

-- Architecture (Arquitetura)
-- Implementação do Projeto
architecture arch_Q2 of Q2 is

    -- Sinais Auxiliares para a Interconexão
    signal A_uns : unsigned(3 downto 0);
    signal B_uns : unsigned(3 downto 0);
    signal S_uns : unsigned(4 downto 0);

begin

    -- Conversão para o tipo UNSIGNED usando o comando unsigned(.)
    A_uns <= unsigned(A);
    B_uns <= unsigned(B);
    S_uns <= unsigned('0' & A_uns) + unsigned('0' & B_uns);
    S <= std_logic_vector(S_uns);

end arch_Q2;
