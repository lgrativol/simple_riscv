
-- TODO : add pakage description

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package pkg_parameters is
  
  -- Setup Parameters
  constant DWIDTH           : NATURAL                                 := 32; -- Datapath width
  constant IWIDTH           : NATURAL                                 := 32; -- Instruction width
  constant INITIAL_ADDRESS  : STD_LOGIC_VECTOR((DWIDTH - 1) downto 0) := x"0000_0000";
  

  -- Instruction Memory Parameters
  constant IM_MAX_ADDRESS   : NATURAL                                 := 2**(IWIDTH) - 1;
  constant IM_ADDR_WIDTH    : NATURAL                                 := 32;
  constant IM_COL_WIDTH     : NATURAL                                 := 8;
  constant IM_NB_COL        : NATURAL                                 := IWIDTH/IM_COL_WIDTH; -- COL_WIDTH * NB_COL = IWIDTH 
  
  -- Register File Parameters
  constant RF_REG_WIDTH    : NATURAL                                 := 32;

end package pkg_parameters;