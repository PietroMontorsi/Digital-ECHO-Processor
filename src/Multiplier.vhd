library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;
use ieee.numeric_std.all;

entity Multiplier is
	port (  Multiplier_In1, Multiplier_In2 : in ufixed(-1 downto -8);
		Multiplier_Out : out ufixed(-1 DOWNTO -16));

end Multiplier;

architecture Behavior of Multiplier is 

begin

Multiplier_Out <= (Multiplier_In1 * Multiplier_In2); 

end Behavior;