library ieee;
use ieee.std_logic_1164.all;

entity UART_TX_ControlUnit is
	port (  TE, BaudCNT_TC, bitCNT_TC, CLOCK, RST : in std_logic;
		FF_LE, FF_RST, PISO_LE, PISO_SE, PISO_SIn, PISO_RST, BaudCNT_CLR, BaudCNT_CE, bitCNT_CLR, bitCNT_CE : out std_logic;
                PISO_START, PISO_STOP : out std_logic);


end UART_TX_ControlUnit;

architecture Behavior of UART_TX_ControlUnit is


type State_Type is (Reset, IDLE, ST1, ST2, ST3, ST4);

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
	if (TE = '1') then
	  PresentState <= ST1;
	else
	  PresentState <= IDLE;
	end if;

  when ST1 => PresentState <= ST2;

  when ST2 => 
	if (BaudCNT_TC = '1') then
          if (bitCNT_TC = '0') then 
            PresentState <= ST3;
          end if;
        end if;    
       
        if (BaudCNT_TC = '0') then
          PresentState <= ST2;  
        end if;  

        if (BaudCNT_TC = '1') then
          if (bitCNT_TC = '1') then
            PresentState <= RESET;    
          end if;
        end if; 

  when ST3 => PresentState <= ST4;

  when ST4 => PresentState <= ST2;

  when others => PresentState <= RESET;
end case;
end if;

end process StateUpdating;

OutputEvaluation : process (PresentState) is
begin

FF_LE <= '0';   
FF_RST <= '0';

PISO_RST <= '0';
PISO_LE <= '0'; 
PISO_SE <= '0';
PISO_START <= '0'; 
PISO_STOP <= '1';
PISO_SIn <= '1';
 
BaudCNT_CLR <= '0'; 
BaudCNT_CE <= '0';  

bitCNT_CLR <= '0'; 
bitCNT_CE <= '0';

case PresentState is 

  when RESET =>
     
     PISO_RST <= '1';
     FF_RST <= '1';
     BaudCNT_CLR <= '1'; 
     bitCNT_CLR <= '1';
     --FF_LE <= '1';  	
  
  when IDLE =>
  
     PISO_RST <= '0';
     FF_RST <= '0';
     BaudCNT_CLR <= '0'; 
     bitCNT_CLR <= '0';
     FF_LE <= '1'; 

  when ST1 =>

     PISO_LE <= '1'; 
     BaudCNT_CLR <= '1';       
     bitCNT_CLR <= '1';     

  when ST2 =>
             
     PISO_LE <= '0';       
     BaudCNT_CLR <= '0'; 
     bitCNT_CLR <= '0';
     BaudCNT_CE <= '1';

  when ST3 =>

     PISO_SE <= '1';
     bitCNT_CE <= '1'; 
     BaudCNT_CE <= '1';

  when ST4 =>
     
     PISO_SE <= '0';
     bitCNT_CE <= '0';
     BaudCNT_CE <= '1'; 

end case;

end process;

end Behavior;

