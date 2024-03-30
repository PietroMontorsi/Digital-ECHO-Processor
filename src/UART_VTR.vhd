library ieee;
use ieee.std_logic_1164.all;

entity UART_VTR is
generic ( N : integer := 3);
	port( bit3in : in std_logic_vector ( 2 downto 0);
	      Dataid: out std_logic); 
end UART_VTR;

architecture Behavior of UART_VTR is 

component UART_MUX2to1 is 
    PORT ( 
	  x0, x1 , s : IN STD_LOGIC;
	  y 	   : OUT STD_LOGIC  );
    END component;


signal VTR_s: std_logic;

begin 

VTR_s <= bit3in(1) xor bit3in(2);

MUX : UART_MUX2to1 port map (
	bit3in(1), bit3in(0), VTR_s, Dataid);
	
end Behavior;
