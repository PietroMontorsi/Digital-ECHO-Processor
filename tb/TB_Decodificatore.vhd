library ieee;
use ieee.std_logic_1164.all;

entity TB_Decodificatore is 

end TB_Decodificatore;

architecture Behavior of TB_Decodificatore is 

component Decodificatore is 
	port (  AsciIn : in std_logic_vector(7 downto 0);
		HexOut : out std_logic_vector(7 downto 0);
		En: in std_logic;
		Ready, Error : out std_logic); 
end component;

component Clk_Gen is
	port ( clk, reset : out std_logic);
end component;

signal TB_AsciIn, TB_HexOut : std_logic_vector (7 downto 0);
signal TB_En, TB_Ready, TB_Error : std_logic;

begin

TB_AsciIn <= "01100001" after 28 ns, "01000001" after 33 ns, "11111111" after 38 ns, "00110001" after 43 ns, "01000110" after 48 ns; 
TB_En <='0', '1' after 5 ns;

Dec : Decodificatore port map (TB_AsciIn, TB_HexOut, TB_En, TB_Ready, TB_Error);


end Behavior;
