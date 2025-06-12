library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity q2 is
port (
A : in std_logic;
B : in std_logic;
C : in std_logic;
D : in std_logic;
E : in std_logic;
F : in std_logic;
G : in std_logic;
S : out std_logic
);
end q2;

architecture arch_q2 of q2 is

component mult_8x1
port (
D : in std_logic_vector(7 downto 0);
S : in std_logic_vector(2 downto 0);
Y : out std_logic
);
end component;

component deco_4x16
port (
A : in std_logic_vector(3 downto 0);
Y : out std_logic_vector(15 downto 0)
);
end component;

signal sig_dec : std_logic_vector(15 downto 0);
signal sig_mux : std_logic_vector(7 downto 0);
signal sel_dec : std_logic_vector(3 downto 0); -- novo
signal sel_mux : std_logic_vector(2 downto 0); -- novo

begin

sel_dec <= A & B & C & D; -- concatenação fora do port map
sel_mux <= E & F & G;

-- Decodificador 4x16
u1: deco_4x16
port map (
A => sel_dec,
Y => sig_dec
);

-- Atribuições do MUX
sig_mux(0) <= '0';
sig_mux(1) <= sig_dec(0) or sig_dec(15);
sig_mux(2) <= sig_dec(7);
sig_mux(3) <= '1';
sig_mux(4) <= sig_dec(9) or sig_dec(15);
sig_mux(5) <= '0';
sig_mux(6) <= sig_dec(10) or sig_dec(11);
sig_mux(7) <= '1';

-- Multiplexador 8x1
u2: mult_8x1
port map (
D => sig_mux,
S => sel_mux,
Y => S
);

end arch_q2;