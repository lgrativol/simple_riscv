------------------------------------------------------------------------------
-- Name : Clock Generator
-- Last Update : 26/12/2023
-- Tested : No
--
-- Desc : A program counter for a CPU design. Basically a 
--        register.
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_generator is
    Generic(
        CLK_PERIOD      : time
    );

    Port ( 
        -- Clock & Reset Interface
        clk			 : out  std_logic
    ); 
end clock_generator;

architecture test_utils of clock_generator is

begin

    clk_process :process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

end architecture;