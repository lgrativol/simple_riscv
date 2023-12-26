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


entity inst_mem_rom is --TODO : find correct way to init this
    generic(
        DATA_WIDTH  : natural;
        SIZE        : natural; --natural number of addresses
        ADDR_WIDTH  : natural; -- adress width [bit width]
        COL_WIDTH   : natural; -- word bit width, accepts 8- and 9-bits + multiples
        NB_COL      : natural  -- number of words per address
    );

    port(
        -- Clock Interface
        clk             : in  std_logic;
        I_addr          : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
        O_data_out      : out std_logic_vector((DATA_WIDTH - 1) downto 0)
    );
    
end inst_mem_rom;
    
    architecture rtl of inst_mem_rom is

    
    begin
    
    Instruction_memory_block : entity work.byte_write_dual_port_mem(rtl)
        generic map(
            SIZE        => SIZE, -- number of addresses
            ADDR_WIDTH  => DATA_WIDTH, -- adress width [bit width]
            COL_WIDTH   => COL_WIDTH, -- word bit width, accepts 8- and 9-bits + multiples
            NB_COL      => NB_COL -- number of words per address
        )
        
        port map(
            -- Interface A
            clka      => clk,
            I_ena     => '1',
            I_wea     => (others => '0'),
            I_addra   => I_addr,
            I_dia     => (others => '0'),
            O_doa     => O_data_out,
    
            -- Interface B
            clkb      => clk,
            I_enb     => '0', -- off
            I_web     => (others => '0'),
            I_addrb   => (others => '0'),
            I_dib     => (others => '0'),
            O_dob     => open
        );


    end rtl;