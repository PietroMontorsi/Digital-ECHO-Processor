library ieee;
use ieee.std_logic_1164.all;

entity ECHO_DSP is

	port( DataIn, Decay, Gain : in std_logic_vector (7 downto 0);	
              Delay : in std_logic_vector( 15 downto 0);     
	      DataValidIn, CLK, RESET : in std_logic;
              DataValidOut : out std_logic;
	      DataOut : out std_logic_vector (7 downto 0));

end ECHO_DSP;

architecture Behavior of ECHO_DSP is

component ECHO_DataPathDsp is
        port (  Input, Decay, Gain : in std_logic_vector(7 downto 0);
		Delay : in std_logic_vector(15 downto 0);
		CLOCK : in std_logic;
		Reg_RST, RegIn_LE, RegADD_LE, RegRHU_LE, RAM_RST, RAM_WRE, RAM_RDE, RegRAM_LE, MUX_S : in std_logic;  
		Output : out std_logic_vector(7 downto 0));

end component;

component ECHO_ControlUnitDsp is
	 port (  CLOCK, RST, DataValidIn : in std_logic;
		 Reg_RST, RegIn_LE, RegADD_LE, RegRHU_LE, RAM_RST, RAM_WRE, RAM_RDE, RegRAM_LE, MUX_S, DataValidOut : out std_logic);  

end component;

--signal W_Input, W_Decay, W_Gain : std_logic_vector(7 downto 0);
--signal W_Delay : std_logic_vector(15 downto 0);
signal W_CLOCK, W_Reg_RST, W_RegIn_LE, W_RegADD_LE, W_RegRHU_LE, W_RAM_RST, W_RAM_WRE, W_RAM_RDE, W_RegRAM_LE, W_MUX_S, W_DataValidOut : std_logic;
--signal W_Output : std_logic_vector(7 downto 0);
signal W_RST, W_DataValidIn : std_logic; 

begin 

DataPathDsp : ECHO_DataPathDsp port map(
        DataIn, Decay, Gain, Delay, CLK, W_Reg_RST, W_RegIn_LE, W_RegADD_LE, W_RegRHU_LE, W_RAM_RST, W_RAM_WRE, W_RAM_RDE, 
        W_RegRAM_LE, W_MUX_S, DataOut);
	
ControlUnitDsp : ECHO_ControlUnitDsp port map(
	CLK, RESET, DataValidIn,
	W_Reg_RST, W_RegIn_LE, W_RegADD_LE, W_RegRHU_LE, W_RAM_RST, W_RAM_WRE, W_RAM_RDE, W_RegRAM_LE, W_MUX_S, DataValidOut);


end Behavior;
