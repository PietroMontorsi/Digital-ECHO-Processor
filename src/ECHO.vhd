library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;


entity ECHO is
	port (  UART_RX,  Data_Valid_IN, CLK, RST : in std_logic;
	        Data_IN : in std_logic_vector (7 downto 0);
           Data_Valid_OUT : out std_logic;
           Data_OUT : out std_logic_vector (7 downto 0);        
	        UART_TX : out std_logic);
  
end ECHO;

architecture Behavior of ECHO is

component ECHO_Instruction is

	port( REG_GAIN, REG_DECAY : out std_logic_vector ( 7 downto 0);
	      REG_DELAY : out std_logic_vector ( 15 downto 0 );
	      ECHO_UART_RX, CLK, RESET : in std_logic;
	      ECHO_UART_TX : out std_logic);

end component;


component ECHO_DSP is

	port( DataIn, Decay, Gain : in std_logic_vector (7 downto 0);	
              Delay : in std_logic_vector( 15 downto 0);     
	      DataValidIn, CLK, RESET : in std_logic;
              DataValidOut : out std_logic;
	      DataOut : out std_logic_vector (7 downto 0));

end component;

signal W_GAIN, W_DECAY : std_logic_vector ( 7 downto 0);
signal W_DELAY : std_logic_vector ( 15 downto 0 );

begin 

Ist : ECHO_Instruction port map(W_GAIN, W_DECAY, W_DELAY, UART_RX, CLK, RST, UART_TX);

DSP : ECHO_DSP port map(Data_IN, W_DECAY, W_GAIN, W_DELAY, Data_Valid_IN, CLK, RST, Data_Valid_OUT, Data_OUT);

end Behavior;

