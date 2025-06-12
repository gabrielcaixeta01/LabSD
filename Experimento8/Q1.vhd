-- Arquivo: Q1.vhd

library ieee;
use ieee.std_logic_1164.all;

entity Q1 is
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
end Q1;

architecture arch_Q1 of Q1 is

    component cont10 is
        port(
            reset : in std_logic;
            clk : in std_logic;
            e : in std_logic;
            rci : in std_logic;
            load : in std_logic;
            D : in std_logic_vector(3 downto 0);
            Q : out std_logic_vector(3 downto 0);
            rco : out std_logic
        );
    end component;

    signal rco_arch : std_logic;

begin

    unid : cont10 port map(
        reset => reset,
        clk => clk,
        e => e,
        rci => '0',
        load => load,
        D => load_uni,
        Q => cont_uni,
        rco => rco_arch
    );

    dez : cont10 port map(
        reset => reset,
        clk => clk,
        e => e,
        rci => rco_arch,
        load => load,
        D => load_dez,
        Q => cont_dez,
        rco => open
    );

end arch_Q1;