library ieee;
use ieee.std_logic_1164.all;

entity somador_complt is
    port(
        A    : in  std_logic;
        B    : in  std_logic;
        Cin  : in  std_logic;
        S    : out std_logic;
        Cout : out std_logic
    );
end somador_complt;

architecture arch_somador_complt of somador_complt is
begin
    S <= A xor B xor Cin;
    Cout <= (A and B) or (A and Cin) or (B and Cin);
end arch_somador_complt;
