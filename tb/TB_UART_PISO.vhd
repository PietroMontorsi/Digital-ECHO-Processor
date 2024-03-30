library ieee;
use ieee.std_logic_1164.all;

entity TB_UART_PISO is
generic  (N : integer := 10);
end TB_UART_PISO;

architecture Behavior of TB_UART_PISO is 
 
component UART_PISO is
generic  (N : integer := 10);
	port ( LE, Sin, clock, reset, SE : in std_logic;
		DataIn         : in std_logic_vector ( N-1 downto 0);
		Sout                : out std_logic);
end component;

component Clk_Gen is
	port ( clk, reset : out std_logic);
end component;

signal INSerial, TB_LE, TB_SE, TB_clock, TB_reset, U : std_logic;
signal INParallel  : std_logic_vector (N-1 downto 0);  

begin

TB_reset <= '1', '0' after 30 ns;
TB_SE <= '0', '1' after 62 ns,'0' after 67 ns, '1' after 72 ns,'0' after 77 ns, '1' after 82 ns,'0' after 87 ns, '1' after 92 ns,'0' after 97 ns, '1' after 102 ns,'0' after 107 ns, '1' after 112 ns,'0' after 117 ns, '1' after 122 ns,'0' after 127 ns, '1' after 132 ns,'0' after 137 ns, '1' after 142 ns,'0' after 147 ns;
TB_LE <= '0','1' after 52 ns, '0' after 57 ns;
INSerial <= '1';
INParallel <="0000000000", "0101011001" after 50 ns , "0000000000" after 60 ns;

Clk_Gen1 : Clk_Gen port map ( 
	clk => TB_clock);

UART_PISO1 : UART_PISO port map (
	LE => TB_LE, SE => TB_SE, Sin => INSerial, clock => TB_clock, reset => TB_reset, DataIn => INParallel, Sout => U); 
		
end Behavior;
