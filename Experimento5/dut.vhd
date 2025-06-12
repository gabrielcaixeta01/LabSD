library ieee;
use ieee.std_logic_1164.all;

entity dut is
    port (
        A : in  std_logic_vector(3 downto 0);
        B : in  std_logic_vector(3 downto 0);
        S : out std_logic_vector(4 downto 0)
    );
end dut;

architecture arch_dut of dut is
    component Q1 is
        port (
            A : in  std_logic_vector(3 downto 0);
            B : in  std_logic_vector(3 downto 0);
            S : out std_logic_vector(4 downto 0)
        );
    end component;
begin
    UUT: Q1 port map (A => A, B => B, S => S);
end arch_dut;