library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_q1 is
end testbench_q1;

architecture arch_testbench_q1 of testbench_q1 is

component q1
port(
A : in std_logic;
B : in std_logic;
C : in std_logic;
X : out std_logic;
Y : out std_logic
);
end component;

signal sig_l : std_logic_vector(2 downto 0);
signal sig_X, sig_Y : std_logic;

begin

uut : q1
port map (
A => sig_l(2),
B => sig_l(1),
C => sig_l(0),
X => sig_X,
Y => sig_Y
);

stim_proc : process
begin
for i in 0 to 7 loop
sig_l <= std_logic_vector(to_unsigned(i, 3));
wait for 5 ns;
end loop;
wait;
end process;

end arch_testbench_q1;