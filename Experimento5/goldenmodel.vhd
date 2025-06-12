library ieee;
use ieee.std_logic_1164.all;

entity goldenmodel is
    port (
        A : in  std_logic_vector(3 downto 0);
        B : in  std_logic_vector(3 downto 0);
        S : out std_logic_vector(4 downto 0)
    );
end goldenmodel;

architecture arch_golden of goldenmodel is
    component Q2 is
        port (
            A : in  std_logic_vector(3 downto 0);
            B : in  std_logic_vector(3 downto 0);
            S : out std_logic_vector(4 downto 0)
        );
    end component;
begin
    UUT: Q2 port map (A => A, B => B, S => S);
end arch_golden;
