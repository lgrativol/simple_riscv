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


entity register_file is --TODO : find correct way to init this
    generic(
        ADDR_WIDTH  : natural;
        DATA_WIDTH  : natural
    );
    port(
        -- Clock Interface & Reset
        clk             : in  std_logic;
        reset           : in  std_logic;
        
        -- Read Interface
        I_read_addr1    : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
        I_read_addr2    : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
        O_data_out1     : out std_logic_vector((DATA_WIDTH - 1) downto 0);      
        O_data_out2     : out std_logic_vector((DATA_WIDTH - 1) downto 0);
        
        -- Write Interface
        I_write_en      : in  std_logic;
        I_write_addr    : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
        I_write_data    : in std_logic_vector((DATA_WIDTH - 1) downto 0)
    );
    
end register_file;
    
architecture rtl of register_file is

    ---------------
    -- Constants --
    ---------------

    constant NB_REGS    : natural := 2**(ADDR_WIDTH);

    -----------
    -- Types --
    -----------

    type reg_array is array(0 to (NB_REGS - 1)) of std_logic_vector ((DATA_WIDTH - 1) downto 0);
    
    -------------
    -- Signals --
    -------------
    
    signal reg_file     : reg_array := (others => (others => '0')); -- assign all 0
    signal is_reg_zero  : std_logic;

    -- Crap signals for lazy people
    signal read_addr1   : natural;
    signal read_addr2   : natural;
    signal write_addr   : natural;

begin
    
    read_addr1 <= to_integer(unsigned(I_read_addr1));
    read_addr2 <= to_integer(unsigned(I_read_addr2));
    write_addr <= to_integer(unsigned(I_write_addr));
    
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                reg_file <= (others => (others => '0'));
            else
                if I_write_en = '1' then
                    if is_reg_zero = '0' then
                        reg_file(write_addr) <= I_write_data;
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    is_reg_zero <=          '1' when write_addr = 0 -- Small workaround for the x0 read-only case
                    else    '0'; 
    
    
    -- Output

    O_data_out1 <= reg_file(read_addr1);
    O_data_out2 <= reg_file(read_addr2);

end rtl;