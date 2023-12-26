
-- TODO : add pakage description

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.pkg_parameters;

-- Package Declaration Section
package pkg_utils is

  function conv_integer (
    vec : in std_logic_vector((pkg_parameters.IM_ADDR_WIDTH - 1) downto 0)
  ) return integer;

end package pkg_utils;

package body pkg_utils is

  function conv_integer (
    vec : in std_logic_vector((pkg_parameters.IM_ADDR_WIDTH - 1) downto 0)
  ) return integer is
  begin
    return to_integer(unsigned(vec));
  end;

end package body pkg_utils;