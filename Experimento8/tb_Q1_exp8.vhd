-- Arquivo: tb_Q1_exp8.vhd

entity tb_Q1_exp8 is
end;

library ieee;
use ieee.std_logic_1164.all;

architecture arch_tb_Q1_exp8 of tb_Q1_exp8 is

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

    signal reset_tb : std_logic := '0';
    signal e_tb : std_logic := '0';
    signal load_tb : std_logic := '0';
    signal clk_tb : std_logic := '1';
    signal load_dez_tb : std_logic_vector(3 downto 0) := "0000";
    signal load_uni_tb : std_logic_vector(3 downto 0) := "0000";
    signal cont_dez_tb : std_logic_vector(3 downto 0);
    signal cont_uni_tb : std_logic_vector(3 downto 0);

begin

    contador : Q1_exp8
        port map(
            reset => reset_tb,
            clk => clk_tb,
            e => e_tb,
            load => load_tb,
            load_dez => load_dez_tb,
            load_uni => load_uni_tb,
            cont_dez => cont_dez_tb,
            cont_uni => cont_uni_tb
        );

    clk_tb <= not clk_tb after 0.5 sec;

    estimulo : process
    begin
        e_tb <= '0'; wait for 55 sec;
        reset_tb <= '1'; wait for 5 sec;
        reset_tb <= '0'; wait for 5 sec;
        e_tb <= '0'; wait for 15 sec;
        e_tb <= '1'; wait for 5 sec;
        e_tb <= '0'; wait for 20 sec;

        load_tb <= '1';
        load_dez_tb <= "1001";
        load_uni_tb <= "0011"; wait for 5 sec;
        load_tb <= '0';

        e_tb <= '0'; wait for 10 sec;

        reset_tb <= '1';
        load_tb <= '1';

        load_dez_tb <= "0100";
        load_uni_tb <= "0110"; wait for 5 sec;

        reset_tb <= '0';
        load_tb <= '0'; wait for 5 sec;

    end process estimulo;

end arch_tb_Q1_exp8;