library ieee;
use ieee.std_logic_1164.all;

entity TB_UART_RX is
generic (NCOMP : integer := 8; N : integer := 8);
end TB_UART_RX;


architecture Behavior of TB_UART_RX is

component CLK_GEN is
	port ( CLK, RST : out std_logic);

end component;

component UART_RX is

generic (NCOMP : integer := 8; N : integer := 8);

         port ( R_X, CLK : in std_logic;
                D_R : out std_logic;
		Dout: out std_logic_vector (N-1 downto 0));

end component;


signal TB_R_X, TB_CLK, TB_D_R : std_logic;
signal TB_Dout : std_logic_vector ( N-1 downto 0 );

begin

TB_R_X <= '1', '0' after 1105 us, 
          '0' after 1210 us, '1' after 1315 us, '0' after 1420 us, '1' after 1525 us, '0' after 1630 us, '1' after 1735 us, '0' after 1840 us, '1' after 1945 us, 
          '1' after 2050 us;

	   

CLOCK : CLK_GEN port map(
	CLK => TB_CLK);

UART : UART_RX port map(
	R_X => TB_R_X, CLK => TB_CLK, Dout => TB_Dout, D_R => TB_D_R);

end Behavior;
