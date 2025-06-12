-- Arquivo: tb_Q2_exp8.vhd

entity tb_Q2_exp8 is
end;

library ieee;
use ieee.std_logic_1164.all;

architecture arch_tb_Q2_exp8 of tb_Q2_exp8 is

    component Q2_exp8 is
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
    end component;

    signal reset_tb : std_logic := '0';
    signal clk_tb : std_logic := '1';
    signal T5_tb : std_logic;
    signal T6_tb : std_logic;
    signal T20_tb : std_logic;
    signal T60_tb : std_logic;
    signal cont_dez_tb : std_logic_vector(3 downto 0);
    signal cont_uni_tb : std_logic_vector(3 downto 0);

begin

    temporizador : Q2_exp8
        port map(
            reset => reset_tb,
            clk => clk_tb,
            T5 => T5_tb,
            T6 => T6_tb,
            T20 => T20_tb,
            T60 => T60_tb,
            cont_dezena => cont_dez_tb,
            cont_unidade => cont_uni_tb
        );

    clk_tb <= not clk_tb after 0.5 sec;

    estimulo : process
    begin
        reset_tb <= '0'; wait for 50 sec;
        reset_tb <= '1'; wait for 5 sec;
        reset_tb <= '0'; wait for 25 sec;
    end process estimulo;

end arch_tb_Q2_exp8;