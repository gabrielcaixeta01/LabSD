-- Testbench para o Decodificador 4x16
library ieee;
use ieee.std_logic_1164.all;

entity tb_Q_2 is
end tb_Q_2;

architecture tb of tb_Q_2 is
    component Q_2
        port (
            A : in std_logic_vector(3 downto 0);
            Y : out std_logic_vector(15 downto 0)
        );
    end component;

    signal A : std_logic_vector(3 downto 0);
    signal Y : std_logic_vector(15 downto 0);

begin
    uut: Q_2 port map (
        A => A,
        Y => Y
    );

    process
    begin
        A <= "0000"; wait for 5 ns;
        A <= "0001"; wait for 5 ns;
        A <= "0010"; wait for 5 ns;
        A <= "0011"; wait for 5 ns;
        A <= "0100"; wait for 5 ns;
        A <= "0101"; wait for 5 ns;
        A <= "0110"; wait for 5 ns;
        A <= "0111"; wait for 5 ns;
        A <= "1000"; wait for 5 ns;
        A <= "1001"; wait for 5 ns;
        A <= "1010"; wait for 5 ns;
        A <= "1011"; wait for 5 ns;
        A <= "1100"; wait for 5 ns;
        A <= "1101"; wait for 5 ns;
        A <= "1110"; wait for 5 ns;
        A <= "1111"; wait for 5 ns;
        wait;
    end process;

end tb;