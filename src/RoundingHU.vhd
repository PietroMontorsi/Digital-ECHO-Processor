LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.fixed_pkg.ALL;
USE ieee.numeric_std.ALL;

entity RoundingHU is
	port (  Rounding_In : in ufixed(-1 downto -16);
		Rounding_Out : out ufixed(-1 downto -8));

end RoundingHU;

architecture Behavior of RoundingHU is

	SIGNAL Res, one : ufixed(-1 downto -9);
	SIGNAL Sum : ufixed(0 DOWNTO -9);

BEGIN

	Res <= Rounding_In(-1 DOWNTO -9);
	one <= "000000001";

	Sum <= Res + one;
	Rounding_Out <= Sum(-1 DOWNTO -8);

END Behavior;
