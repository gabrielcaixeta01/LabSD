library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity quest1 is
    Port (
        CLOCK         : in  STD_LOGIC;
        RESET         : in  STD_LOGIC;
        A             : in  STD_LOGIC_VECTOR (1 downto 0);
        REFRIGERANTE  : out STD_LOGIC;
        TROCO25       : out STD_LOGIC;
        TROCO50       : out STD_LOGIC
    );
end quest1;

architecture Behavioral of quest1 is

    type state_type is (
        S0, -- 0,00
        S25, -- 0,25
        S50, -- 0,50
        S75, -- 0,75
        S100, -- >=1,00 libera refrigerante
        DEV75, -- devolver 0,75
        DEV50, -- devolver 0,50
        DEV25, -- devolver 0,25
        CANCEL -- estado auxiliar p/ cancelamento
    );

    signal state, next_state : state_type;

begin

    process(CLOCK, RESET)
    begin
        if RESET = '1' then
            state <= S0;
        elsif rising_edge(CLOCK) then
            state <= next_state;
        end if;
    end process;

    process(state, A)
    begin
        -- Default outputs
        REFRIGERANTE <= '0';
        TROCO25 <= '0';
        TROCO50 <= '0';
        next_state <= state;

        case state is
            when S0 =>
                if A = "01" then
                    next_state <= S25;
                elsif A = "10" then
                    next_state <= S50;
                elsif A = "11" then
                    next_state <= CANCEL;
                end if;

            when S25 =>
                if A = "01" then
                    next_state <= S50;
                elsif A = "10" then
                    next_state <= S75;
                elsif A = "11" then
                    next_state <= DEV25;
                end if;

            when S50 =>
                if A = "01" then
                    next_state <= S75;
                elsif A = "10" then
                    next_state <= S100;
                elsif A = "11" then
                    next_state <= DEV50;
                end if;

            when S75 =>
                if A = "01" or A = "10" then
                    next_state <= S100;
                elsif A = "11" then
                    next_state <= DEV75;
                end if;

            when S100 =>
                REFRIGERANTE <= '1';
                next_state <= S0;

            when DEV75 =>
                TROCO50 <= '1';
                TROCO25 <= '1';
                next_state <= S0;

            when DEV50 =>
                TROCO50 <= '1';
                next_state <= S0;

            when DEV25 =>
                TROCO25 <= '1';
                next_state <= S0;

            when CANCEL =>
                -- Devolve tudo com base no estado anterior (tratado no diagrama de estados)
                next_state <= S0;

            when others =>
                next_state <= S0;

        end case;
    end process;

end Behavioral;