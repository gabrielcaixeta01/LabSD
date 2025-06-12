-- Arquivo: timeflags_exp8.vhd

library ieee;
use ieee.std_logic_1164.all;

entity timeflags_exp8 is
    port(
        cont_dezena : in std_logic_vector(3 downto 0);
        cont_unidade : in std_logic_vector(3 downto 0);
        T5 : out std_logic;
        T6 : out std_logic;
        T20 : out std_logic;
        T60 : out std_logic
    );
end timeflags_exp8;

architecture arch_timeflags_exp8 of timeflags_exp8 is
begin
    T5 <= '1' when (cont_dezena = "0000" and cont_unidade >= "0101") else
          '1' when (cont_dezena > "0000") else
          '0';

    T6 <= '1' when (cont_dezena = "0000" and cont_unidade >= "0110") else
          '1' when (cont_dezena > "0000") else
          '0';

    T20 <= '1' when (cont_dezena >= "0010") else
           '0';

    T60 <= '1' when (cont_dezena >= "0110") else
           '0';
end arch_timeflags_exp8;