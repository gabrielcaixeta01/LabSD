library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_Somador4 is
end testbench_Somador4;

architecture arch_testbench_Somador4 of testbench_Somador4 is

    component Q1 is
        port (
            A : in  std_logic_vector(3 downto 0);
            B : in  std_logic_vector(3 downto 0);
            S : out std_logic_vector(4 downto 0)
        );
    end component;

    signal A, B : std_logic_vector(3 downto 0) := (others => '0');
    signal S    : std_logic_vector(4 downto 0);

begin

    UUT: Q1
        port map (
            A => A,
            B => B,
            S => S
        );

    stim_proc: process
    begin
        for i in 0 to 15 loop
            for j in 0 to 15 loop
                A <= std_logic_vector(to_unsigned(i, 4));
                B <= std_logic_vector(to_unsigned(j, 4));
                wait for 5 ns;
            end loop;
        end loop;
        wait;
    end process;

end arch_testbench_Somador4;