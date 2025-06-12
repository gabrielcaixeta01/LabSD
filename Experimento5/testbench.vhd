library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
    port (
        A_tb   : out std_logic_vector(3 downto 0);
        B_tb   : out std_logic_vector(3 downto 0);
        dut_tb : in  std_logic_vector(4 downto 0);
        gm_tb  : in  std_logic_vector(4 downto 0)
    );
end testbench;

architecture arch_testbench of testbench is
begin

    stim_proc: process
    begin
        for i in 0 to 15 loop
            for j in 0 to 15 loop
                A_tb <= std_logic_vector(to_unsigned(i, 4));
                B_tb <= std_logic_vector(to_unsigned(j, 4));
                wait for 500 ps;
                assert (dut_tb = gm_tb)
                    report "Erro: DUT /= GM" severity ERROR;
            end loop;
        end loop;
        wait;
    end process;

end arch_testbench;
