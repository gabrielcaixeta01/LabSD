library ieee;
use ieee.std_logic_1164.all;

entity mult_8x1 is
port (
D : in std_logic_vector(7 downto 0);
S : in std_logic_vector(2 downto 0);
Y : out std_logic
);
end mult_8x1;

architecture behavior of mult_8x1 is
begin
process(D, S)
begin
case S is
when "000" => Y <= D(0);
when "001" => Y <= D(1);
when "010" => Y <= D(2);
when "011" => Y <= D(3);
when "100" => Y <= D(4);
when "101" => Y <= D(5);
when "110" => Y <= D(6);
when "111" => Y <= D(7);
when others => Y <= '0';
end case;
end process;
end behavior;