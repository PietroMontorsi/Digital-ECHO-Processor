library ieee;
use ieee.std_logic_1164.all;

entity UART_RX_ControlUnit is
	port (  COMP_STR, SYNCNT_TC, bitCNT_TC, CLOCK, RST, X8CNT_TC : in std_logic;
		     X8SIPO_RST, X1SIPO_SE, X1SIPO_RST, SYNCNT_CE, SYNCNT_CLR, bitCNT_CE, bitCNT_CLR, DR: out std_logic);
              

end UART_RX_ControlUnit;

architecture Behavior of UART_RX_ControlUnit is

--Dichiarare i segnali!

type State_Type is (Reset, IDLE, ST1, ST2, ST3, ST4, ST5);

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
	if ( COMP_STR = '1') then
	  PresentState <= ST1;
	else
	  PresentState <= IDLE;
	end if;

  when ST1 => 
	if (SYNCNT_TC = '1') then
          if (bitCNT_TC = '0') then 
            PresentState <= ST2;
          end if;
        end if;    
       
	if (SYNCNT_TC = '0') then
          if (bitCNT_TC = '0') then 
            PresentState <= ST1;
          end if;
        end if;    

  

  when ST2 => PresentState <= ST3; 
		 
  when ST3 => 
  
  if (SYNCNT_TC = '0') then
          if (bitCNT_TC = '0') then 
            PresentState <= ST1;
         end if;
   else  
       
   --if (SYNCNT_TC = '1') then
          if (bitCNT_TC = '1') then 
            PresentState <= ST4;
          --end if;
   else 
        PresentState <= ST1;
				
	end if;			
	end if; 
	

  when ST4 => 
       if (SYNCNT_TC = '1') then
          if (bitCNT_TC = '1') then 
            PresentState <= ST5;
          end if;
   else 
          PresentState <= ST4;
				
	end if;			
	
	

	
 when ST5 => PresentState <= RESET;

	

  when others => PresentState <= RESET;
end case;
end if;

end process StateUpdating;

OutputEvaluation : process (PresentState) is
begin




X8SIPO_RST <= '0';

X1SIPO_SE <= '0';
X1SIPO_RST <= '0';

SYNCNT_CE <= '1';
SYNCNT_CLR <= '0';

bitCNT_CE <= '0';
bitCNT_CLR <= '0';

DR <= '0';

case PresentState is 

  when RESET =>
     
     X8SIPO_RST <= '1';
     X1SIPO_RST <= '1';
     SYNCNT_CLR <= '1'; 
     bitCNT_CLR <= '1'; 
	  SYNCNT_CE <= '0';  
  
  when IDLE =>
  
     X8SIPO_RST <= '0';
     X1SIPO_RST <= '0';
     SYNCNT_CLR <= '0'; 
     bitCNT_CLR <= '0'; 
     SYNCNT_CE <= '0';

  when ST1 =>

      --SYNCNT_CE <= '1';     

  when ST2 =>
     
	 
     bitCNT_CE <= '1';
     --SYNCNT_CE <= '1';
	  X1SIPO_SE <= '1';  

  when ST3 =>
      
     bitCNT_CE <= '0'; 
     --X1SIPO_SE <= '1';
     --SYNCNT_CE <= '1';
     X1SIPO_SE <= '0';
	  
	  
  when ST4 =>
     
	   
     -- X1SIPO_SE <= '0';
     --SYNCNT_CE <= '1';
    
	  
  when ST5 => 
  
     DR <= '1';
     --SYNCNT_CE <= '1';   

end case;

end process;

end Behavior;

