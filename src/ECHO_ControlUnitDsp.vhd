library ieee;
use ieee.std_logic_1164.all;

entity ECHO_ControlUnitDsp is
	port (  
		CLOCK, RST, DataValidIn : in std_logic;
		--Decay, Gain : in std_logic_vector(7 downto 0);
		--Delay : out std_logic_vector(15 downto 0);
		Reg_RST, RegIn_LE, RegADD_LE, RegRHU_LE, RAM_RST, RAM_WRE, RAM_RDE, RegRAM_LE, MUX_S, DataValidOut : out std_logic);                

end ECHO_ControlUnitDsp;

architecture Behavior of ECHO_ControlUnitDsp is

--Dichiarare i segnali!

type State_Type is (Reset, IDLE, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9, ST10);

signal PresentState : State_Type; 

begin

StateUpdating : process (CLOCK, RST) is
begin

if RST = '1' then 
  PresentState <= RESET;
elsif CLOCK'event and CLOCK = '1' then

case PresentState is

  when RESET => PresentState <= IDLE;
  
  when IDLE => 
	if (DataValidIn = '1') then
	  PresentState <= ST1;
	else
	  PresentState <= IDLE;
	end if;

  when ST1 => PresentState <= ST2; 
	
  when ST2 => PresentState <= ST3; 

  when ST3 => PresentState <= ST4; 
	
  when ST4 => PresentState <= ST5; 

  when ST5 => PresentState <= ST6; 
	
  when ST6 => PresentState <= ST7; 
		 	
  when ST7 => PresentState <= ST8; 

  when ST8 => PresentState <= ST9;
	
  when ST9 => PresentState <= ST10; 	
	
  when ST10 => PresentState <= RESET;

  when others => PresentState <= RESET;

end case;
end if;

end process StateUpdating;

OutputEvaluation : process (PresentState) is
begin

Reg_RST <= '0';
RegIn_LE <= '0';
RegADD_LE <= '0';
RegRHU_LE <= '0';
RegRAM_LE <= '0';

RAM_RST <= '0';
RAM_WRE <= '0';
RAM_RDE<= '0';
 
MUX_S <= '0';

DataValidOut <= '0';

case PresentState is 

  when RESET =>
     
     Reg_RST <= '1';
     --RAM_RST <= '1';
  
  when IDLE =>

     RegIn_LE <= '1'; 	  

  when ST1 =>
    
     RegIn_LE <= '0';
     RAM_RDE<= '1';

  when ST2 =>
     
     RAM_RDE<= '0';
     RegRAM_LE <= '1';

  when ST3 =>
      
     
  when ST4 =>
     
     RegRHU_LE <= '1'; 
	  
  when ST5 => 

     RegRHU_LE <= '0';
     MUX_S <= '1';
     RegADD_LE <= '1';
 
  when ST6 => 

     RegADD_LE <= '0';
     MUX_S <= '1';
     RAM_WRE <= '1';

  when ST7 => 

     RAM_WRE <= '0';
     MUX_S <= '1';
     RegRHU_LE <= '1';

  when ST8 => 

     MUX_S <= '0';
     RegRHU_LE <= '0';
     RegADD_LE <= '1';

  when ST9 => 

     DataValidOut <= '1';

  when ST10 =>  

     DataValidOut <= '0'; 
 
end case;

end process;

end Behavior;

