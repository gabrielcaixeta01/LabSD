library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.numeric_std.all;

entity tb_flipflop is
end tb_flipflop;

architecture arch_tb_flipflop of tb_flipflop is

    component flipflop is
        port(
            pr, clr, clk, J, K : in std_logic;
            Q : out std_logic
        );
    end component;

    signal pr   : std_logic := '0';
    signal clr  : std_logic := '0';
    signal clk  : std_logic := '0';
    signal J    : std_logic := '0';
    signal K    : std_logic := '0';
    signal Q    : std_logic;

begin

    flipflopJK : flipflop
        port map(
            pr => pr,
            clr => clr,
            clk => clk,
            J => J,
            K => K,
            Q => Q
        );

    clk <= not clk after 5 ns;

    estimulo : process
    begin
        for i in 0 to 4 loop
            pr  <= std_logic(to_unsigned(i, 2)(1));
            clr <= std_logic(to_unsigned(i, 2)(0));

            J <= '0'; K <= '0'; wait for 10 ns;
            J <= '0'; K <= '1'; wait for 10 ns;
            J <= '1'; K <= '1'; wait for 10 ns;
            J <= '1'; K <= '0'; wait for 10 ns;
        end loop;
        wait;
    end process estimulo;

end arch_tb_flipflop;