library ieee;
use ieee.std_logic_1164.all;

entity UART_TX is

generic (PISO_N : integer := 10; N : integer := 8);

         port ( T_E, CLK : in std_logic;
                Data : in std_logic_vector ( N-1 downto 0 );
		T_X: out std_logic);

end UART_TX;

architecture Behavior of UART_TX is

component UART_TX_DataPath is

generic (PISO_N : integer := 10; N : integer := 8);

         port ( CLOCK, FF_LE, FF_RST, PISO_LE, PISO_SE, PISO_SIn, PISO_RST, BaudCNT_CLR, BaudCNT_CE, bitCNT_CLR, bitCNT_CE : in std_logic;
		PISO_START, PISO_STOP : in std_logic;    -- rispettivamente 0 e 1;
		Din : in std_logic_vector ( N-1 downto 0 );
		TX, BaudCNT_TC, bitCNT_TC : out std_logic);
end component;

component UART_TX_ControlUnit is
	port (  TE, BaudCNT_TC, bitCNT_TC, CLOCK, RST : in std_logic;
		FF_LE, FF_RST, PISO_LE, PISO_SE, PISO_SIn, PISO_RST, BaudCNT_CLR, BaudCNT_CE, bitCNT_CLR, bitCNT_CE : out std_logic;
                PISO_START, PISO_STOP : out std_logic);
end component;

signal W_CLOCK, W_FF_LE, W_FF_RST, W_PISO_LE, W_PISO_SE, W_PISO_SIn, W_PISO_RST, W_BaudCNT_CLR, W_BaudCNT_CE, W_bitCNT_CLR, W_bitCNT_CE : std_logic;
signal W_PISO_START, W_PISO_STOP : std_logic;
signal W_TX, W_BaudCNT_TC, W_bitCNT_TC, W_RST : std_logic;

begin

DataPath : UART_TX_DataPath port map(
	CLK, W_FF_LE, W_FF_RST, W_PISO_LE, W_PISO_SE, W_PISO_SIn, W_PISO_RST, W_BaudCNT_CLR, W_BaudCNT_CE, W_bitCNT_CLR, W_bitCNT_CE,
        W_PISO_START, W_PISO_STOP, Data,
	T_X, W_BaudCNT_TC, W_bitCNT_TC);

ControlUnit : UART_TX_ControlUnit port map(
	T_E, W_BaudCNT_TC, W_bitCNT_TC, CLK, W_RST,
	W_FF_LE, W_FF_RST, W_PISO_LE, W_PISO_SE, W_PISO_SIn, W_PISO_RST, W_BaudCNT_CLR, W_BaudCNT_CE, W_bitCNT_CLR, W_bitCNT_CE,
	W_PISO_START, W_PISO_STOP);

end Behavior;

