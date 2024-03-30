library ieee;
use ieee.std_logic_1164.all;

entity TB_UART_COMP is

end TB_UART_COMP;

architecture Behavior of TB_UART_COMP is 

component UART_COMP is
generic ( NCOMP : integer);
	port( IN1 , IN2 : in std_logic_vector (NCOMP-1 downto 0);
	      OutCOMP : out std_logic); 
end component;


signal TB_IN1, TB_IN2 : std_logic_vector (7 downto 0);
signal TB_OutCOMP : std_logic;

begin

TB_IN1 <= "10100100", "00000100" after 5 ns, "11100101" after 10 ns, "10111100" after 15 ns, "10000100" after 20 ns, "10000000" after 25 ns, "11110000" after 30 ns,
           "10000101" after 35 ns, "11100000" after 40 ns, "11110000" after 45 ns, "00001111" after 50 ns, "11110001" after 55 ns, "10100110" after 60 ns; 
TB_IN2 <= "11110000";

Comparatore : UART_COMP 
	generic map (NCOMP => 8)
	port map ( IN1 => TB_IN1, IN2 => TB_IN2, OutCOMP => TB_OutCOMP);


end Behavior;
