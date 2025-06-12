library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_std.all;

entity flipflop is
    port(
        pr, clr, clk, J, K : in std_logic;
        Q : out std_logic
    );
end flipflop;

architecture arch_flipflop of flipflop is
    signal sig_1 : std_logic_vector(1 downto 0);
    signal sig_2 : std_logic := '0';
begin
    sig_1 <= J & K;

    process(pr, clr, clk)
    begin
        if pr = '1' then
            sig_2 <= '1';
        elsif clr = '1' then
            sig_2 <= '0';
        elsif rising_edge(clk) then
            if sig_1 = "01" then sig_2 <= '0'; end if;
            if sig_1 = "10" then sig_2 <= '1'; end if;
            if sig_1 = "11" then sig_2 <= not(sig_2); end if;
        end if;
    end process;

    Q <= sig_2;
end arch_flipflop;