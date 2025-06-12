entity topmodule is
end topmodule;

-- Package (Pacote)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- Architecture (Arquitetura)
architecture arch_topmodule of topmodule is

    -- Declaração da componente dut do arquivo "dut.vhd"
    component dut is
        port (
            A : in  std_logic_vector(3 downto 0);
            B : in  std_logic_vector(3 downto 0);
            S : out std_logic_vector(4 downto 0)
        );
    end component;

    -- Declaração da componente gm do arquivo "goldenmodel.vhd"
    component goldenmodel is
        port (
            A : in  std_logic_vector(3 downto 0);
            B : in  std_logic_vector(3 downto 0);
            S : out std_logic_vector(4 downto 0)
        );
    end component;

    -- Declaração da componente testbench do arquivo "testbench.vhd"
    component testbench is
        port (
            A_tb   : out std_logic_vector(3 downto 0);
            B_tb   : out std_logic_vector(3 downto 0);
            dut_tb : in  std_logic_vector(4 downto 0);
            gm_tb  : in  std_logic_vector(4 downto 0)
        );
    end component;

    -- Sinais Auxiliares para a Interconexão
    signal sig_1 : std_logic_vector(3 downto 0);
    signal sig_2 : std_logic_vector(3 downto 0);
    signal sig_3 : std_logic_vector(4 downto 0);
    signal sig_4 : std_logic_vector(4 downto 0);

begin

    -- Instância do DUT com Interconexão dos sinais
    DUT_top : dut
        port map (
            A => sig_1,
            B => sig_2,
            S => sig_3
        );

    -- Instância do Golden Model com Interconexão dos sinais
    GM_top : goldenmodel
        port map (
            A => sig_1,
            B => sig_2,
            S => sig_4
        );

    -- Instância do Testbench com Interconexão dos sinais
    TB_top : testbench
        port map (
            A_tb   => sig_1,
            B_tb   => sig_2,
            dut_tb => sig_3,
            gm_tb  => sig_4
        );

end arch_topmodule;
