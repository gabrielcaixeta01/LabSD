-- Arquivo: Q2.vhd

library ieee;
use ieee.std_logic_1164.all;

entity Q2 is
    port(
        clk : in std_logic;
        reset : in std_logic;
        T5 : out std_logic;
        T6 : out std_logic;
        T20 : out std_logic;
        T60 : out std_logic;
        cont_dezena : out std_logic_vector(3 downto 0);
        cont_unidade : out std_logic_vector(3 downto 0)
    );
end Q2;

architecture arch_Q2 of Q2 is

    component Q1 is
        port(
            reset : in std_logic;
            clk : in std_logic;
            e : in std_logic;
            load : in std_logic;
            load_dez : in std_logic_vector(3 downto 0);
            load_uni : in std_logic_vector(3 downto 0);
            cont_dez : out std_logic_vector(3 downto 0);
            cont_uni : out std_logic_vector(3 downto 0)
        );
    end component;

    component timeflags is
        port(
            cont_dezena : in std_logic_vector(3 downto 0);
            cont_unidade : in std_logic_vector(3 downto 0);
            T5 : out std_logic;
            T6 : out std_logic;
            T20 : out std_logic;
            T60 : out std_logic
        );
    end component;

    signal dez : std_logic_vector(3 downto 0);
    signal uni : std_logic_vector(3 downto 0);

begin

    contador : Q1
        port map(
            reset => reset,
            clk => clk,
            e => '0',
            load => '0',
            load_dez => "0000",
            load_uni => "0000",
            cont_dez => dez,
            cont_uni => uni
        );

    flags : timeflags
        port map(
            cont_dezena => dez,
            cont_unidade => uni,
            T5 => T5,
            T6 => T6,
            T20 => T20,
            T60 => T60
        );

    cont_dezena <= dez;
    cont_unidade <= uni;

end arch_Q2;