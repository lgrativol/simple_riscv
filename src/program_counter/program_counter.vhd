------------------------------------------------------------------------------
-- Name : Program Counter
-- Last Update : 12/12/2023
-- Tested : No
--
-- Desc : A program counter for a CPU design. Basically a 
--        register.
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.pkg_parameters.all;


entity program_counter is
    Generic(
        DATA_WIDTH      : natural;
        INITIAL_ADDRESS : std_logic_vector
    );

    Port ( 
        -- Clock & Reset Interface
        clk			 : in  std_logic;
        reset        : in  std_logic;
        -- Input -- 
        I_pc_next    : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
        -- Output --
        O_pc         : out std_logic_vector((DATA_WIDTH - 1) downto 0)

    ); 
end program_counter;


architecture rtl of program_counter is

    -------------
    -- SIGNALS --
    -------------

    signal pc_next : unsigned((DATA_WIDTH - 1 ) downto 0);
    signal pc : unsigned((DATA_WIDTH - 1 ) downto 0);

begin

    -- Input
    pc_next <= unsigned(I_pc_next);

    counter: process (clk)
    begin
        if rising_edge(clk) then
            if(reset = '1') then
                pc <= unsigned(INITIAL_ADDRESS);
            else
                pc <= pc_next;
            end if;
        end if;    
    end process;


    -- Output
    O_pc <= std_logic_vector(pc);

end architecture;