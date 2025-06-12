library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registra is
    port(
        clk, rst, load, dir, L, R : in std_logic;
        D : in std_logic_vector(3 downto 0);
        Q : out std_logic_vector(3 downto 0)
    );
end registra;

architecture arch_registra of registra is
    signal sig_l : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                sig_l <= (others => '0');
            elsif load = '1' then
                sig_l <= D;
            else
                if dir = '0' then
                    sig_l <= sig_l(2 downto 0) & L;
                elsif dir = '1' then
                    sig_l <= R & sig_l(3 downto 1);
                end if;
            end if;
        end if;
    end process;

    Q <= sig_l;
end arch_registra;