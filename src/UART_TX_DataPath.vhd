library ieee;
use ieee.std_logic_1164.all;

entity UART_TX_DataPath is

generic (PISO_N : integer := 10; N : integer := 8);

         port ( CLOCK, FF_LE, FF_RST, PISO_LE, PISO_SE, PISO_SIn, PISO_RST, BaudCNT_CLR, BaudCNT_CE, bitCNT_CLR, bitCNT_CE : in std_logic;
		PISO_START, PISO_STOP : in std_logic;    -- rispettivamente 0 e 1;
		Din : in std_logic_vector ( 7 downto 0 );
		TX, BaudCNT_TC, bitCNT_TC : out std_logic);

end UART_TX_DataPath;

architecture Behavior of UART_TX_DataPath is

component UART_REGISTER is 
generic (N : integer := 8);
	port (  D : in std_logic_vector (N-1 downto 0);
		CLK, RST, LE : in std_logic;
		Q : out std_logic_vector(N-1 downto 0));
end component;

component UART_CNT is
generic (N : integer);
	port( CLR, CE, CLK : in std_logic;
	      CNT : out integer range 0 to N;
	      TC : out std_logic); 
end component;

component UART_PISO is 
generic (PISO_N : integer := 10);
	port ( LE, SIn, CLK, RST, SE : in std_logic;
		DIn : in std_logic_vector ( PISO_N-1 downto 0);
		QSer : out std_logic);
end component;

 
signal BusFFtoPISO : std_logic_vector ( N-1 downto 0);

begin

Registro: UART_REGISTER port map (
	  D => Din, CLK => CLOCK, RST => FF_RST, LE => FF_LE, Q => BusFFtoPISO); 

PISO: UART_PISO port map (
	LE => PISO_LE, SIn => PISO_SIn, CLK => CLOCK, RST => PISO_RST, SE => PISO_SE,   	
	DIn(0) => PISO_STOP,
        DIn(1) => BusFFtoPISO(7), DIn(2) => BusFFtoPISO(6), DIn(3) => BusFFtoPISO(5), DIn(4) => BusFFtoPISO(4), DIn(5) => BusFFtoPISO(3),
	DIn(6) => BusFFtoPISO(2), DIn(7) => BusFFtoPISO(1), DIn(8) => BusFFtoPISO(0),
        DIn(9) => PISO_START,
	QSer => TX);


bitCNT: UART_CNT
generic map ( N => 9 )  
port map (CLR => bitCNT_CLR, CE => bitCNT_CE, CLK => CLOCK, TC => bitCNT_TC); 

BaudCNT: UART_CNT
generic map ( N => 1041 )
port map (CLR => BaudCNT_CLR, CE => BaudCNT_CE, CLK => CLOCK, TC => BaudCNT_TC); 

end Behavior;