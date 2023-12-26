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
use work.pkg_utils.all;


entity byte_write_dual_port_mem is -- TODO : create init function option
    generic(
        SIZE        : integer; -- number of addresses
        ADDR_WIDTH  : integer; -- adress width [bit width]
        COL_WIDTH   : integer; -- word bit width, accepts 8- and 9-bits + multiples
        NB_COL      : integer  -- number of words per address
    );
    
    port(
        -- Interface A
        clka      : in  std_logic;
        I_ena     : in  std_logic;
        I_wea     : in  std_logic_vector((NB_COL - 1) downto 0); -- byte-write enable A
        I_addra   : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
        I_dia     : in  std_logic_vector((NB_COL * COL_WIDTH - 1) downto 0);
        O_doa     : out std_logic_vector((NB_COL * COL_WIDTH - 1) downto 0);

        -- Interface B
        clkb      : in  std_logic;
        I_enb     : in  std_logic;
        I_web     : in  std_logic_vector((NB_COL - 1) downto 0); -- byte-write enable B
        I_addrb   : in  std_logic_vector((ADDR_WIDTH - 1) downto 0);
        I_dib     : in  std_logic_vector((NB_COL * COL_WIDTH - 1) downto 0);
        O_dob     : out std_logic_vector((NB_COL * COL_WIDTH - 1) downto 0)
    );
    
end byte_write_dual_port_mem;
    
    architecture rtl of byte_write_dual_port_mem is
    ----------
    -- Type --
    ----------

    type ram_type is array (0 to SIZE - 1) of std_logic_vector((NB_COL * COL_WIDTH - 1) downto 0);
    
    --------------
    -- Variable --
    --------------
    
    shared variable RAM : ram_type := (others => (others => '0')); -- Init at zero
    
    begin
    
    ----------------------
    ------- Port A -------
    ----------------------

    process(clka)
    begin
        if rising_edge(clka) then
            if I_ena = '1' then
                O_doa <= RAM(conv_integer(I_addra));
                for i in 0 to NB_COL - 1 loop
                    if I_wea(i) = '1' then
                        RAM(conv_integer(I_addra))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) := I_dia((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                    end if;
                end loop;
            end if;
        end if;
    end process;

    ----------------------
    ------- Port B -------
    ----------------------

    process(clkb)
    begin
        if rising_edge(clkb) then
            if I_enb = '1' then
                O_dob <= RAM(conv_integer(I_addrb));
                for i in 0 to NB_COL - 1 loop
                    if I_web(i) = '1' then
                        RAM(conv_integer(I_addrb))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) := I_dib((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                    end if;
                end loop;
            end if;
        end if;
    end process;

    end rtl;