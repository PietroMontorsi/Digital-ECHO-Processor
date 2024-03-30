library ieee;
use ieee.std_logic_1164.all;

entity TB_UART_SIPO is 

end TB_UART_SIPO;

architecture Behavior of TB_UART_SIPO is

component UART_SIPO is 
generic  (N : integer := 8);
	port (  SIn, CLK, RST, SE : in std_logic;
		QParall     : out std_logic_vector (N-1 downto 0));
end component;

component CLK_GEN is
	port ( CLK, RST : out std_logic);
end component;

signal TB_SIn, TB_CLK, TB_RST, TB_SE : std_logic;
signal TB_QParall : std_logic_vector(7 downto 0); 

begin 

TB_SIn <= '0','1' after 30 ns, '0' after 35 ns, '1' after 40 ns, '0' after 45 ns, '1' after 50 ns, '0' after 55 ns, '1' after 60 ns, '1' after 65 ns,
	'1' after 70 ns, '1' after 75 ns, '1' after 80 ns, '1' after 85 ns, '1' after 90 ns, '1' after 95 ns, '1' after 100 ns, '0' after 105 ns,
	'0' after 110 ns, '0' after 115 ns, '0' after 120 ns, '0' after 125 ns, '0' after 130 ns, '0' after 135 ns, '0' after 140 ns, '0' after 145 ns; 
TB_SE <= '1'; 
TB_RST <= '1', '0' after 10 ns;

PISO : UART_SIPO port map (
	SIn => TB_SIn, CLK => TB_CLK, RST => TB_RST, SE => TB_SE, QParall => TB_QParall);

CLK : CLK_GEN port map(
	CLK => TB_CLK);

end Behavior;