library ieee;
use ieee.std_logic_1164.all;

entity q1 is
port(
A : in std_logic;
B : in std_logic;
C : in std_logic;
X : out std_logic;
Y : out std_logic
);
end q1;

architecture arch_q1 of q1 is

component multiplex is
port(
D : in std_logic_vector(3 downto 0);
S : in std_logic_vector(1 downto 0);
Y : out std_logic
);
end component;

signal sig_1 : std_logic_vector(3 downto 0);
signal sig_2 : std_logic_vector(3 downto 0);
signal sig_3 : std_logic_vector(1 downto 0);

begin

mult1 : multiplex
port map(D => sig_1, S => sig_3, Y => X);

sig_1(3) <= '1';
sig_1(2) <= not C;
sig_1(1) <= C;
sig_1(0) <= '0';

sig_3(1) <= A;
sig_3(0) <= B;

mult2 : multiplex
port map(D => sig_2, S => sig_3, Y => Y);

sig_2(3) <= '1';
sig_2(2) <= not C;
sig_2(1) <= '0';
sig_2(0) <= C;

end arch_q1;