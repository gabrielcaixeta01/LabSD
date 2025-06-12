library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity deco_4x16 is
port (
A : in std_logic_vector(3 downto 0);
Y : out std_logic_vector(15 downto 0)
);
end deco_4x16;

architecture behavior of deco_4x16 is
begin
process(A)
begin
Y <= (others => '0');
Y(to_integer(unsigned(A))) <= '1';
end process;
end behavior;