-- Arquivo: tb_Q3_exp8.vhd

entity tb_Q3_exp8 is
end;

library ieee;
use ieee.std_logic_1164.all;

architecture arch_tb_Q3_exp8 of tb_Q3_exp8 is

    component Q3_exp8 is
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
    end component;

    signal ligadesliga_tb : std_logic := '1';
    signal clk_tb : std_logic := '1';
    signal sensorA_tb : std_logic := '0';
    signal sensorB_tb : std_logic := '0';
    signal cont_dezena_tb : std_logic_vector(3 downto 0);
    signal cont_unidade_tb : std_logic_vector(3 downto 0);
    signal semaforoA_tb : std_logic_vector(2 downto 0);
    signal semaforoB_tb : std_logic_vector(2 downto 0);

begin

    sistema : Q3_exp8
        port map(
            ligadesliga => ligadesliga_tb,
            sensorA => sensorA_tb,
            sensorB => sensorB_tb,
            clk => clk_tb,
            cont_dezena => cont_dezena_tb,
            cont_unidade => cont_unidade_tb,
            semaforoA => semaforoA_tb,
            semaforoB => semaforoB_tb
        );

    clk_tb <= not clk_tb after 0.5 sec;

    estimulo : process
    begin
        sensorA_tb <= '1';
        sensorB_tb <= '1'; wait for 70 sec;

        ligadesliga_tb <= '0'; wait for 5 sec;
        ligadesliga_tb <= '1';

        sensorA_tb <= '0';
        sensorB_tb <= '1'; wait for 20 sec;

        ligadesliga_tb <= '0'; wait for 5 sec;
        ligadesliga_tb <= '1';

        sensorA_tb <= '0';
        sensorB_tb <= '0'; wait for 50 sec;

        sensorB_tb <= '0'; wait for 50 sec;

        sensorA_tb <= '1'; wait for 10 sec;
    end process estimulo;

end arch_tb_Q3_exp8;