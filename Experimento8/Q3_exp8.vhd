-- Arquivo: Q3_exp8.vhd

library ieee;
use ieee.std_logic_1164.all;

entity Q3_exp8 is
    port(
        clk : in std_logic;
        ligadesliga : in std_logic;
        sensorA : in std_logic;
        sensorB : in std_logic;
        cont_dezena : out std_logic_vector(3 downto 0);
        cont_unidade : out std_logic_vector(3 downto 0);
        semaforoA : out std_logic_vector(2 downto 0);
        semaforoB : out std_logic_vector(2 downto 0)
    );
end Q3_exp8;

architecture arch_Q3_exp8 of Q3_exp8 is

    component Q1_exp8 is
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

    component timeflags_exp8 is
        port(
            cont_dezena : in std_logic_vector(3 downto 0);
            cont_unidade : in std_logic_vector(3 downto 0);
            T5 : out std_logic;
            T6 : out std_logic;
            T20 : out std_logic;
            T60 : out std_logic
        );
    end component;

    component maqestados_exp8 is
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
    end component;

    signal reset : std_logic;
    signal T5_arch : std_logic;
    signal T6_arch : std_logic;
    signal T20_arch : std_logic;
    signal T60_arch : std_logic;
    signal dez : std_logic_vector(3 downto 0);
    signal uni : std_logic_vector(3 downto 0);

begin

    contador : Q1_exp8
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

    flags : timeflags_exp8
        port map(
            cont_dezena => dez,
            cont_unidade => uni,
            T5 => T5_arch,
            T6 => T6_arch,
            T20 => T20_arch,
            T60 => T60_arch
        );

    estados : maqestados_exp8
        port map(
            ligadesliga => ligadesliga,
            clk => clk,
            sensorA => sensorA,
            sensorB => sensorB,
            T5 => T5_arch,
            T6 => T6_arch,
            T20 => T20_arch,
            T60 => T60_arch,
            resetcounter => reset,
            semaforoA => semaforoA,
            semaforoB => semaforoB
        );

    cont_dezena <= dez;
    cont_unidade <= uni;

end arch_Q3_exp8;