------------------------------------------------------------------------------
-- TODO : finish description
-- Name : 
-- Last Update : 
-- Tested : 
--
-- Desc : Bla bli blo
------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.pkg_parameters.all;


entity inst_mem_ram is --TODO : find correct way to init this
    port(
        -- Clock Interface
        clk             : in  std_logic;
        I_addr          : in  std_logic_vector((IM_ADDR_WIDTH - 1) downto 0);
        O_data_out      : out std_logic_vector((IWIDTH - 1) downto 0)
    );
    
end inst_mem_ram;
    
    architecture rtl of inst_mem_ram is

    
    begin
    
    --TODO : finish RAM code


    end rtl;