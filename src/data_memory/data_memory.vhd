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


entity data_memory is --TODO : find correct way to init this
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
        I_write_en      : in  std_logic;
        I_write_data    : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
        O_data_out      : out std_logic_vector((DATA_WIDTH - 1) downto 0)
    );
    
end data_memory;
    
architecture rtl of data_memory is

    -------------
    -- Signals --
    -------------

    signal write_enable : std_logic_vector((NB_COL - 1) downto 0);

begin
    
    data_memory_block : entity work.byte_write_dual_port_mem(rtl)
        generic map(
            SIZE        => SIZE, -- number of addresses
            ADDR_WIDTH  => DATA_WIDTH, -- adress width [bit width]
            COL_WIDTH   => COL_WIDTH, -- word bit width, accepts 8- and 9-bits + multiples
            NB_COL      => NB_COL -- number of words per address
        )
        
        port map(
            -- Interface A
            clka      => clk,
            I_ena     => '1', -- enable port A
            I_wea     => write_enable,
            I_addra   => I_addr,
            I_dia     => I_write_data,
            O_doa     => O_data_out,
    
            -- Interface B
            clkb      => clk,
            I_enb     => '0', -- disable port B
            I_web     => (others => '0'),
            I_addrb   => (others => '0'),
            I_dib     => (others => '0'),
            O_dob     => open
        );

    
    write_enable    <=          (others => '1') when I_write_en = '1' 
                        else    (others => '0');


end rtl;