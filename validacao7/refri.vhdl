library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity q1_exp7_50c is
    port (
        A        : in  std_logic_vector(1 downto 0);  -- "10" = R$0,50; "11" = cancel; "00" = nada
        clock    : in  std_logic;
        reset    : in  std_logic;
        Refri    : out std_logic;  -- libera refrigerante
        troco_50 : out std_logic   -- devolve moeda de 50c
    );
end entity;
 
architecture behavior of q1_exp7_50c is
    -- Estados: 0c, 50c, 100c, 150c e devolução 50c
    type estados is (Init, S50, S100, S150, D50);
    signal estado_atual, prox_estado: estados;
begin
    -- Processo síncrono: atualiza estado
    processo_reg: process(clock, reset)
    begin
        if reset = '1' then
            estado_atual <= Init;
        elsif rising_edge(clock) then
            estado_atual <= prox_estado;
        end if;
    end process;
 
    -- Processo combinacional: transições e saídas (Moore)
    processo_comb: process(estado_atual, A)
    begin
        -- Valores default
        Refri    <= '0';
        troco_50 <= '0';
        prox_estado <= Init;
 
        case estado_atual is
            when Init =>
                case A is
                    when "10" => prox_estado <= S50;        -- 50c
                    when others => prox_estado <= Init;     -- nada ou cancel
                end case;
 
            when S50 =>
                case A is
                    when "10" => prox_estado <= S100;      -- 100c
                    when "11" => prox_estado <= D50;        -- cancelar, devolve 50c
                    when others => prox_estado <= S50;       -- permanece
                end case;
 
            when S100 =>
                case A is
                    when "10" => prox_estado <= S150;      -- 150c extra
                    when "11" => prox_estado <= D50;        -- cancelar, devolve 50c (última)
                    when others =>                          -- sem nova moeda
                        Refri    <= '1';                    -- libera refrigerante em 100c
                        prox_estado <= Init;
                end case;
 
            when S150 =>                                  -- 150c: libera + troco 50c
                Refri    <= '1';
                troco_50 <= '1';
                prox_estado <= Init;
 
            when D50 =>                                   -- devolve 50c e reseta
                troco_50 <= '1';
                prox_estado <= Init;
        end case;
    end process;
end architecture;