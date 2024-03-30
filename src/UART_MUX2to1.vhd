LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY UART_MUX2to1 IS
PORT ( 
	x0, x1 , s : IN STD_LOGIC;
	y 	   : OUT STD_LOGIC  );
END UART_MUX2to1;

ARCHITECTURE Behavior OF UART_MUX2to1 IS

BEGIN 

WITH s SELECT

y <= x0 WHEN '0',
     x1 WHEN OTHERS;

END Behavior;
