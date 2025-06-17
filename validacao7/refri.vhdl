library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity refri is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        A1    : in std_logic;
        A0    : in std_logic;
        Q1    : out std_logic;
        Q0    : out std_logic
    );
end entity;

architecture behavioral of refri is
    type state_type is (Idle, e50c, e100c, d50c);
    signal current_state, next_state : state_type;
begin

    -- Process for state transition
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= Idle;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Process for next state logic
    process(current_state, A1, A0)
    begin
        case current_state is
            when Idle =>
                if (A1 = '0' and A0 = '1') then
                    next_state <= e50c;
                else
                    next_state <= Idle;
                end if;

            when e50c =>
                if (A1 = '1' and A0 = '1') then
                    next_state <= d50c;
                elsif (A1 = '0' and A0 = '1') then
                    next_state <= e100c;
                elsif (A1 = '1' and A0 = '0') or (A1 = '0' and A0 = '0') then
                    next_state <= e50c;
                else
                    next_state <= e50c;
                end if;

            when e100c =>
                if (A1 = '0' and A0 = '1') then
                    next_state <= e50c;
                else
                    next_state <= Idle;
                end if;

            when d50c =>
                if (A1 = '0' and A0 = '1') then
                    next_state <= e50c;
                else
                    next_state <= Idle;
                end if;

        end case;
    end process;

    -- Output logic (Moore Machine)
    process(current_state)
    begin
        case current_state is
            when Idle   => Q1 <= '0'; Q0 <= '0';
            when e50c   => Q1 <= '0'; Q0 <= '0';
            when e100c  => Q1 <= '1'; Q0 <= '0';
            when d50c   => Q1 <= '0'; Q0 <= '1';
        end case;
    end process;

end architecture;