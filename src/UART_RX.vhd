library ieee;
use ieee.std_logic_1164.all;

entity UART_RX is

generic (NCOMP : integer := 8; N : integer := 8);

         port ( R_X, CLK : in std_logic;
                D_R : out std_logic;
		Dout: out std_logic_vector (N-1 downto 0));
end UART_RX;

architecture Behavior of UART_RX is

component UART_RX_DataPath is

generic (NCOMP : integer := 8; N : integer := 8);

         port ( CLOCK, RX, X8SIPO_SE, X8SIPO_RST, X1SIPO_SE, X1SIPO_RST, SYNCNT_CE, SYNCNT_CLR, bitCNT_CE, bitCNT_CLR : in std_logic;
		          COMP_STR, SYNCNT_TC, bitCNT_TC, X8CNT_TC: out std_logic;
		          DATAOUT : out std_logic_vector ( N-1 downto 0);
		          X8CNT_CLR, X8CNT_CE : in std_logic);

end component;

component UART_RX_ControlUnit is
	port (  COMP_STR, SYNCNT_TC, bitCNT_TC, CLOCK, RST, X8CNT_TC: in std_logic;
		     X8SIPO_RST, X1SIPO_SE, X1SIPO_RST, SYNCNT_CE, SYNCNT_CLR, bitCNT_CE, bitCNT_CLR, DR: out std_logic);

end component;

component UART_RX_ControlUnit2 is
	port (  X8CNT_TC, CLOCK, RST : in std_logic;
		     X8SIPO_SE, X8CNT_CLR, X8CNT_EN: out std_logic);
              
end component;

signal W_X8SIPO_SE, W_X8SIPO_RST, W_X1SIPO_SE, W_X1SIPO_RST, W_SYNCNT_CE, W_SYNCNT_CLR, W_bitCNT_CE, W_bitCNT_CLR: std_logic;
signal W_COMP_STR, W_SYNCNT_TC, W_bitCNT_TC: std_logic;
signal W_DATAOUT, W_DR, W_RST, W_X8CNT_CLR, W_X8CNT_CE, W_X8CNT_TC : std_logic;

begin

DataPath : UART_RX_DataPath port map(
	CLK, R_X, W_X8SIPO_SE, W_X8SIPO_RST, W_X1SIPO_SE, W_X1SIPO_RST, W_SYNCNT_CE, W_SYNCNT_CLR, W_bitCNT_CE, W_bitCNT_CLR,
        W_COMP_STR, W_SYNCNT_TC, W_bitCNT_TC, W_X8CNT_TC, Dout, W_X8CNT_CLR, W_X8CNT_CE);

ControlUnit : UART_RX_ControlUnit port map(
	W_COMP_STR, W_SYNCNT_TC, W_bitCNT_TC, CLK, W_RST, W_X8CNT_TC,
	W_X8SIPO_RST, W_X1SIPO_SE, W_X1SIPO_RST, W_SYNCNT_CE, W_SYNCNT_CLR, W_bitCNT_CE, W_bitCNT_CLR,
	D_R);

ControlUnit2 :	UART_RX_ControlUnit2 port map( 
	 W_X8CNT_TC, CLK, W_RST, 
	 W_X8SIPO_SE, W_X8CNT_CLR, W_X8CNT_CE);
	
	
end Behavior;

