library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_q2 is
end testbench_q2;

architecture arch_testbench_q2 of testbench_q2 is

component q2
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
end component;

signal sig : std_logic_vector(6 downto 0);
signal S_out : std_logic;

begin

dut: q2
port map (
A => sig(6),
B => sig(5),
C => sig(4),
D => sig(3),
E => sig(2),
F => sig(1),
G => sig(0),
S => S_out
);

stim: process
begin
for i in 0 to 127 loop
sig <= std_logic_vector(to_unsigned(i, 7));
wait for 5 ns;
end loop;
wait;
end process;

end arch_testbench_q2;