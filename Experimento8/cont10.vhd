-- Arquivo: cont10.vhd

library ieee;
use ieee.std_logic_1164.all;

entity cont10 is
    port (
        reset : in std_logic;
        clk : in std_logic;
        e : in std_logic;
        rci : in std_logic;
        load : in std_logic;
        D : in std_logic_vector(3 downto 0);
        Q : out std_logic_vector(3 downto 0);
        rco : out std_logic
    );
end cont10;

architecture arch_cont10 of cont10 is
    type state is (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9);
    signal currentstate, nextstate, loadstate: state;
begin
    with D select
        loadstate <= ST0 when "0000",
                     ST1 when "0001",
                     ST2 when "0010",
                     ST3 when "0011",
                     ST4 when "0100",
                     ST5 when "0101",
                     ST6 when "0110",
                     ST7 when "0111",
                     ST8 when "1000",
                     ST9 when "1001",
                     ST0 when others;

    sync_proc: process(clk)
    begin
        if rising_edge(clk) then
            currentstate <= nextstate;
        end if;
    end process sync_proc;

    comb_proc: process(currentstate, reset, e, rci, load, loadstate)
    begin
        case currentstate is
            when ST0 =>
                Q <= "0000";
                rco <= '1';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST1;
                else nextstate <= currentstate;
                end if;

            when ST1 =>
                Q <= "0001";
                rco <= '1';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST2;
                else nextstate <= currentstate;
                end if;

            when ST2 =>
                Q <= "0010";
                rco <= '1';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST3;
                else nextstate <= currentstate;
                end if;

            when ST3 =>
                Q <= "0011";
                rco <= '1';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST4;
                else nextstate <= currentstate;
                end if;

            when ST4 =>
                Q <= "0100";
                rco <= '1';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST5;
                else nextstate <= currentstate;
                end if;

            when ST5 =>
                Q <= "0101";
                rco <= '1';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST6;
                else nextstate <= currentstate;
                end if;

            when ST6 =>
                Q <= "0110";
                rco <= '1';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST7;
                else nextstate <= currentstate;
                end if;

            when ST7 =>
                Q <= "0111";
                rco <= '1';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST8;
                else nextstate <= currentstate;
                end if;

            when ST8 =>
                Q <= "1000";
                rco <= '1';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST9;
                else nextstate <= currentstate;
                end if;

            when ST9 =>
                Q <= "1001";
                rco <= '0';
                if reset = '1' then nextstate <= ST0;
                elsif load = '1' then nextstate <= loadstate;
                elsif (e = '0') and (rci = '0') then nextstate <= ST0;
                else nextstate <= currentstate;
                end if;
        end case;
    end process comb_proc;
end arch_cont10;