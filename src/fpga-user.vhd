library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library lpm;
use lpm.lpm_components.all;
library altera_mf;
use altera_mf.altera_mf_components.all;

entity user is
	port
	(
		-- Main clock inputs
		mainClk	: in std_logic;
		slowClk	: in std_logic;
		-- Main reset input
		reset		: in std_logic;
		-- MCU interface (UART, I2C)
		mcuUartTx	: in std_logic;
		mcuUartRx	: out std_logic;
		mcuI2cScl	: in std_logic;
		mcuI2cSda	: inout std_logic;
		-- Logic state analyzer/stimulator
		lsasBus	: inout std_logic_vector( 31 downto 0 );
		-- Dip switches
		switches	: in std_logic_vector( 7 downto 0 );
		-- LEDs
		leds		: out std_logic_vector( 3 downto 0 )
	);
end user;

architecture behavioural of user is

	signal clk: std_logic;
	signal pllLock: std_logic;

	signal lsasBusIn: std_logic_vector( 31 downto 0 );
	signal lsasBusOut: std_logic_vector( 31 downto 0 );
	signal lsasBusEn: std_logic_vector( 31 downto 0 ) := ( others => '0' );

	signal mcuI2cDIn: std_logic;
	signal mcuI2CDOut: std_logic;
	signal mcuI2cEn: std_logic := '0';	

	component myAltPll
		PORT
		(
			areset		: IN STD_LOGIC  := '0';
			inclk0		: IN STD_LOGIC  := '0';
			c0		: OUT STD_LOGIC ;
			locked		: OUT STD_LOGIC 
		);
	end component;
	
component ECHO is

	port (  UART_RX,  Data_Valid_IN, CLK, RST : in std_logic;
	        Data_IN : in std_logic_vector (7 downto 0);
           Data_Valid_OUT : out std_logic;
           Data_OUT : out std_logic_vector (7 downto 0);        
	        UART_TX : out std_logic);

end component;

	
	
	signal Data_IN, Data_OUT : std_logic_vector ( 7 downto 0);
	signal UART_RX, Data_Valid_IN, UART_TE, Data_Valid_OUT, UART_TX, RST : std_logic;

	
begin

--**********************************************************************************
--* Main clock PLL
--**********************************************************************************

	myAltPll_inst : myAltPll PORT MAP (
		areset	 => reset,
		inclk0	 => mainClk,
		c0	 => clk,
		locked	 => pllLock
	);

--**********************************************************************************
--* LEDs
--**********************************************************************************

	leds <= switches( 3 downto 0 );
	
--**********************************************************************************
--* Logic state analyzer/stimulator dummy process definition
--* Just a simple up counter
--* 		lsasBus	: inout std_logic_vector( 31 downto 0 )
--**********************************************************************************

	lsasBusIn <= lsasBus;

	lsasBus_tristate:
	process( lsasBusEn, lsasBusOut ) is
	begin
		for index in 0 to 31 loop
			if lsasBusEn( index ) = '1'  then
				lsasBus( index ) <= lsasBusOut ( index );
			else
				lsasBus( index ) <= 'Z';
			end if;
		end loop;
	end process;
	
	
	
	 ECO:  ECHO port map ( Data_IN => Data_IN, Data_OUT => Data_OUT, UART_TX => UART_TX, UART_RX => UART_RX,  
	                       Data_Valid_IN => Data_Valid_IN, CLK => mainClk, Data_Valid_OUT => Data_Valid_OUT, RST => RST);
    	
	
end behavioural;
