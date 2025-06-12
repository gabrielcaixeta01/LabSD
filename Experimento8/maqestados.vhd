-- Arquivo: maqestados.vhd

library ieee;
use ieee.std_logic_1164.all;

entity maqestados is
    port(
        clk : in std_logic;
        ligadesliga : in std_logic;
        sensorA : in std_logic;
        sensorB : in std_logic;
        T5 : in std_logic;
        T6 : in std_logic;
        T20 : in std_logic;
        T60 : in std_logic;
        resetcounter : out std_logic;
        semaforoA : out std_logic_vector(2 downto 0);
        semaforoB : out std_logic_vector(2 downto 0)
    );
end maqestados;

architecture arch_maqestados of maqestados is

    type state is (A_green, B_green, A_yellow, B_yellow, both_red1, both_red2, inter_yellow, inter_off);

    signal currentstate, nextstate: state;

begin

    sync_proc: process(clk, ligadesliga)
    begin
        if (rising_edge(clk)) or (rising_edge(ligadesliga)) or (falling_edge(ligadesliga)) then
            currentstate <= nextstate;
        end if;
    end process sync_proc;

    comb_proc: process(ligadesliga, sensorA, sensorB, T5, T6, T20, T60, currentstate)
    begin
        case currentstate is
            when A_green =>
                semaforoA <= "001";
                semaforoB <= "100";
                if ligadesliga = '0' then
                    nextstate <= inter_yellow;
                    resetcounter <= '1';
                elsif T60 = '1' or (sensorB = '1' and sensorA = '0' and T20 = '1') then
                    nextstate <= A_yellow;
                    resetcounter <= '1';
                else
                    nextstate <= currentstate;
                    resetcounter <= '0';
                end if;

            when A_yellow =>
                semaforoA <= "010";
                semaforoB <= "100";
                if ligadesliga = '0' then
                    nextstate <= inter_yellow;
                    resetcounter <= '1';
                elsif T6 = '1' then
                    nextstate <= both_red1;
                    resetcounter <= '1';
                else
                    nextstate <= currentstate;
                    resetcounter <= '0';
                end if;

            when both_red1 =>
                semaforoA <= "100";
                semaforoB <= "100";
                if ligadesliga = '0' then
                    nextstate <= inter_yellow;
                    resetcounter <= '1';
                elsif T5 = '1' then
                    nextstate <= B_green;
                    resetcounter <= '1';
                else
                    nextstate <= currentstate;
                    resetcounter <= '0';
                end if;

            when B_green =>
                semaforoA <= "100";
                semaforoB <= "001";
                if ligadesliga = '0' then
                    nextstate <= inter_yellow;
                    resetcounter <= '1';
                elsif T60 = '1' or (sensorA = '1' and sensorB = '0' and T20 = '1') then
                    nextstate <= B_yellow;
                    resetcounter <= '1';
                else
                    nextstate <= currentstate;
                    resetcounter <= '0';
                end if;

            when B_yellow =>
                semaforoA <= "100";
                semaforoB <= "010";
                if ligadesliga = '0' then
                    nextstate <= inter_yellow;
                    resetcounter <= '1';
                elsif T6 = '1' then
                    nextstate <= both_red2;
                    resetcounter <= '1';
                else
                    nextstate <= currentstate;
                    resetcounter <= '0';
                end if;

            when both_red2 =>
                semaforoA <= "100";
                semaforoB <= "100";
                if ligadesliga = '0' then
                    nextstate <= inter_yellow;
                    resetcounter <= '1';
                elsif T5 = '1' then
                    nextstate <= A_green;
                    resetcounter <= '1';
                else
                    nextstate <= currentstate;
                    resetcounter <= '0';
                end if;

            when inter_yellow =>
                semaforoA <= "010";
                semaforoB <= "010";
                if ligadesliga = '1' then
                    nextstate <= A_green;
                    resetcounter <= '1';
                else
                    nextstate <= inter_off;
                    resetcounter <= '0';
                end if;

            when inter_off =>
                semaforoA <= "000";
                semaforoB <= "000";
                if ligadesliga = '1' then
                    nextstate <= A_green;
                    resetcounter <= '1';
                else
                    nextstate <= inter_yellow;
                    resetcounter <= '0';
                end if;

        end case;
    end process;

end arch_maqestados;