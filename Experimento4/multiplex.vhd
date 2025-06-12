library ieee;
use ieee.std_logic_1164.all;

entity multiplex is
port(
D : in std_logic_vector(3 downto 0);
S : in std_logic_vector(1 downto 0);
Y : out std_logic
);
end multiplex;

architecture behavior of multiplex is
begin
process(D, S)
begin
case S is
when "00" => Y <= D(0);
when "01" => Y <= D(1);
when "10" => Y <= D(2);
when "11" => Y <= D(3);
when others => Y <= '0';
end case;
end process;
end behavior;