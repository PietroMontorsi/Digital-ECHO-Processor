LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

ENTITY MUX2to1 IS
PORT ( 
	Mux_In1, Mux_In2 : in std_logic_vector(7 downto 0);
	S : in std_logic;
	Mux_Out : out ufixed(-1 downto -8));
END MUX2to1;

ARCHITECTURE Behavior OF MUX2to1 IS

signal x1, x2 : ufixed(-1 downto -8);
 
BEGIN 

x1 <= to_ufixed(Mux_In1,-1,-8);
x2 <= to_ufixed(Mux_In2,-1,-8);

WITH S SELECT

Mux_Out <= x1 WHEN '0',
           x2 WHEN OTHERS;

END Behavior;    
	
		
		