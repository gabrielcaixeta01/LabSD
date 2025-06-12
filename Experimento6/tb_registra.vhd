library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_registra is
end entity;

architecture arch_testbench_registra of testbench_registra is

    component registra is
        port(
            clk, rst, load, dir, L, R : in std_logic;
            D : in std_logic_vector(3 downto 0);
            Q : out std_logic_vector(3 downto 0)
        );
    end component;

    signal CLOCK : std_logic := '0';
    signal RESET : std_logic := '0';
    signal LOAD  : std_logic := '0';
    signal DIR   : std_logic := '0';
    signal L     : std_logic := '0';
    signal R     : std_logic := '0';
    signal D     : std_logic_vector(3 downto 0) := (others => '0');
    signal Q     : std_logic_vector(3 downto 0);

begin

    TestBenchRegistrador : registra
        port map(
            clk  => CLOCK,
            rst  => RESET,
            load => LOAD,
            dir  => DIR,
            L    => L,
            R    => R,
            D    => D,
            Q    => Q
        );

    CLOCK <= not CLOCK after 10 ns;

    estimulo : process
    begin
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';

        LOAD <= '1';
        D <= "1010";
        wait for 20 ns;
        LOAD <= '0';

        DIR <= '0';
        for i in 0 to 3 loop
            L <= std_logic(to_unsigned(i, 1)(0));
            wait for 20 ns;
        end loop;

        DIR <= '1';
        for i in 0 to 3 loop
            R <= std_logic(to_unsigned(i, 1)(0));
            wait for 20 ns;
        end loop;

        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';

        wait;
    end process;

end architecture arch_testbench_registra;