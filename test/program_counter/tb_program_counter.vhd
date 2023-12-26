------------------------------------------------------------------------------
-- Name : Testbench Program Counter
-- Last Update : 12/12/2023
-- Tested : No
--
-- Desc : A program counter for a CPU design. Basically a 
--        register.
------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.pkg_parameters.all;


entity tb_program_counter is
--
end tb_program_counter;


architecture testbench of tb_program_counter is
        
    ---------------
    -- Constants --
    ---------------

    constant CLK_PERIOD     : time := 10 ns;

    -------------
    -- Signals --
    -------------
    
    signal clk	      : std_logic;
    signal reset      : std_logic;
    -- Input -- 
    signal pc_next    : std_logic_vector((IWIDTH - 1) downto 0);
    -- Output --
    signal pc         : std_logic_vector((IWIDTH - 1) downto 0);

begin


    clock_gen : entity work.clock_generator
        Generic Map(
            CLK_PERIOD   => CLK_PERIOD
        )
    
        Port Map ( 
            clk	 => clk
        );

    uut : entity work.program_counter 
        Generic map(
            DATA_WIDTH      => IWIDTH,
            INITIAL_ADDRESS => INITIAL_ADDRESS
        )
    
        Port MAP( 
            -- Clock & Reset Interface
            clk			 => clk,
            reset        => reset,
            -- Input -- 
            I_pc_next    => pc_next,
            -- Output --
            O_pc         => pc
    
        ); 

        stim_proc : process
        begin
    
            for i in 0 to 31 loop
                pc_next <= std_logic_vector(to_unsigned(i,pc_next'length));
                wait for CLK_PERIOD;
                wait until (rising_edge(clk));
            end loop;

            wait;
            
        end process;


end architecture;