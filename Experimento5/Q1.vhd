library ieee;
use ieee.std_logic_1164.all;


entity Q1 is
    port(
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        S : out std_logic_vector(4 downto 0)
    );
end Q1;


architecture arch_Somador of Q1 is

   
    component somador_complt is
        port(
            A    : in std_logic;
            B    : in std_logic;
            Cin  : in std_logic;
            S    : out std_logic;
            Cout : out std_logic
        );
    end component;


    signal carry0 : std_logic;
    signal carry1 : std_logic;
    signal carry2 : std_logic;


begin

   
    somador1: somador_complt port map(
        A => A(0),
        B => B(0),
        Cin => '0',
        S => S(0),
        Cout => carry0
    );

    somador2: somador_complt port map(
        A => A(1),
        B => B(1),
        Cin => carry0,
        S => S(1),
        Cout => carry1
    );

    somador3: somador_complt port map(
        A => A(2),
        B => B(2),
        Cin => carry1,
        S => S(2),
        Cout => carry2
    );

    somador4: somador_complt port map(
        A => A(3),
        B => B(3),
        Cin => carry2,
        S => S(3),
        Cout => S(4)
    );

end arch_Somador;
