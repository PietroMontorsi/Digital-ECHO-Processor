library ieee;
use ieee.std_logic_1164.all;

entity TB_UART_TX_ControlUnit is

end TB_UART_TX_ControlUnit;

architecture Behavior of TB_UART_TX_ControlUnit is

component CLK_GEN is
	port ( CLK, RST : out std_logic);

end component;

component UART_TX_ControlUnit is
	port (  TE, BaudCNT_TC, bitCNT_TC, CLOCK, RST : in std_logic;
		FF_LE, FF_RST, PISO_LE, PISO_SE, PISO_SIn, PISO_RST, BaudCNT_CLR, BaudCNT_CE, bitCNT_CLR, bitCNT_CE : out std_logic;
                PISO_START, PISO_STOP : out std_logic);
end component;

signal TB_TE, TB_BaudCNT_TC, TB_bitCNT_TC, TB_CLOCK, TB_RST : std_logic;
signal TB_FF_LE, TB_FF_RST, TB_PISO_LE, TB_PISO_SE, TB_PISO_SIn, TB_PISO_RST, TB_BaudCNT_CLR, TB_BaudCNT_CE, TB_bitCNT_CLR, TB_bitCNT_CE : std_logic;

begin

TB_TE <= '0', '1' after 32 ns, '0' after 37 ns, '1' after 1021 ns, '0' after 1026 ns;
TB_BaudCNT_TC <= '0', '1' after 102 ns, '0' after 107 ns, '1' after 202 ns, '0' after 207 ns, '1' after 302 ns, '0' after 307 ns, '1' after 402 ns, '0' after 407 ns, '1' after 502 ns, '0' after 507 ns, 
                 '1' after 602 ns, '0' after 607 ns, '1' after 702 ns, '0' after 707 ns, '1' after 802 ns, '0' after 807 ns, '1' after 902 ns, '0' after 907 ns, '1' after 1002 ns, '0' after 1007 ns;
TB_bitCNT_TC  <= '0', '1' after 907 ns, '0' after 1007 ns;              

CLK_GEN1 : CLK_GEN port map(
	CLK => TB_CLOCK);

ControlUnit :  UART_TX_ControlUnit port map(
	         TB_TE, TB_BaudCNT_TC, TB_bitCNT_TC, TB_CLOCK, TB_RST,
		 TB_FF_LE, TB_FF_RST, TB_PISO_LE, TB_PISO_SE, TB_PISO_SIn, TB_PISO_RST, TB_BaudCNT_CLR, 
                 TB_BaudCNT_CE, TB_bitCNT_CLR, TB_bitCNT_CE);


end Behavior;
