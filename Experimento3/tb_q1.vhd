-- Testbench para o Multiplexador 8x1
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Q_1 is
end tb_Q_1;

architecture tb of tb_Q_1 is
    component Q_1
        port (
            D : in std_logic_vector(7 downto 0);
            B : in std_logic;
            S : in std_logic_vector(2 downto 0);
            Y : out std_logic
        );
    end component;

    signal D : std_logic_vector(7 downto 0);
    signal B : std_logic := '0';
    signal S : std_logic_vector(2 downto 0);
    signal Y : std_logic;

begin
    uut: Q_1 port map (
        D => D,
        B => B,
        S => S,
        Y => Y
    );

    process
    begin
        D <= "10110101";  -- Valor fixo para os testes
        S <= "000"; B <= '0'; wait for 5 ns;
        S <= "001"; B <= '0'; wait for 5 ns;
        S <= "010"; B <= '1'; wait for 5 ns;
        S <= "011"; B <= '1'; wait for 5 ns;
        S <= "100"; B <= '0'; wait for 5 ns;
        S <= "101"; B <= '0'; wait for 5 ns;
        S <= "110"; B <= '1'; wait for 5 ns;
        S <= "111"; B <= '1'; wait for 5 ns;
        wait;
    end process;

end tb;