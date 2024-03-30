library ieee;
use ieee.std_logic_1164.all;

entity ECHO_ControlUnitIst is
	 port ( FF_LE, FF_RST, DEC_EN, REG_LE_GAIN, REG_LE_DECAY, REG_LE_DELAY_H, REG_LE_DELAY_L, REG_RST: out std_logic;
		--REG_RST_GAIN, REG_RST_DECAY, REG_RST_DELAY_H, REG_RTS_DELAY_L : in std_logic; 
		CLOCK, RST, UART_DR, DEC_READY, DEC_ERROR : in std_logic;
		Ist : in std_logic_vector (1 downto 0));

end ECHO_ControlUnitIst;

architecture Behavior of ECHO_ControlUnitIst is

--Dichiarare i segnali!

type State_Type is (Reset, IDLE, ISTR, ST0 ,GAIN, DECAY, DELAY, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9, ST10, ST11, ST12);

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
	if (UART_DR = '1') then
	  PresentState <= ST0;
	else
	  PresentState <= IDLE;
	end if;

  when ST0 => PresentState <= ISTR;

  when ISTR => 
	 case Ist is
	   when "11" => PresentState <= DELAY;
	   when "01" => PresentState <= GAIN;
           when "10" => PresentState <= DECAY;
           when "00" => PresentState <= IDLE;
           when others => PresentState <= IDLE;
         end case;

  when GAIN => 
       if (UART_DR = '1') then
            PresentState <= ST1;
       else 
	    PresentState <= GAIN;
       end if;    
    
		 
  when DECAY =>
	if (UART_DR = '1') then
            PresentState <= ST2;
        else 
	    PresentState <= DECAY;
        end if;    

  when DELAY => 
        if (UART_DR = '1') then
            PresentState <= ST3;
        else 
	    PresentState <= DECAY;
        end if;    
	
 when ST9 => 
        if (UART_DR = '1') then
            PresentState <= ST10;
        else 
	    PresentState <= ST9;
        end if;

   when ST1 => PresentState <= ST4;
         
   when ST2 => PresentState <= ST5; 
 
   when ST3 => PresentState <= ST6;

   when ST4 => 
	if (UART_DR = '0') then
          if (DEC_READY = '0') then
	    if (DEC_ERROR = '0') then	 
            PresentState <= GAIN;
            end if;
          end if; 
        end if;   
       
	if (UART_DR = '0') then
          if (DEC_READY = '1') then
            if (DEC_ERROR = '0') then 
            PresentState <= ST7;
            end if;
          end if;
        end if;

	if (DEC_ERROR = '1') then
          PresentState <= IDLE;
        end if;

   when ST5 => 
        if (UART_DR = '0') then
          if (DEC_READY = '0') then
	    if (DEC_ERROR = '0') then	 
            PresentState <= DECAY;
            end if;
          end if; 
        end if;   
       
	if (UART_DR = '0') then
          if (DEC_READY = '1') then
            if (DEC_ERROR = '0') then 
            PresentState <= ST8;
            end if;
          end if;
        end if;

	if (DEC_ERROR = '1') then
          PresentState <= IDLE;
        end if;

   when ST6 => 
	if (UART_DR = '0') then
          if (DEC_READY = '0') then
	    if (DEC_ERROR = '0') then	 
            PresentState <= DELAY;
            end if;
          end if; 
        end if;   
       
	if (UART_DR = '0') then
          if (DEC_READY = '1') then
            if (DEC_ERROR = '0') then 
            PresentState <= ST9;
            end if;
          end if;
        end if;

	if (DEC_ERROR = '1') then
          PresentState <= IDLE;
        end if;

   when ST7 => PresentState <= IDLE;  

   when ST8 => PresentState <= IDLE;

   when ST10 => PresentState <= ST11;

   when ST11 => 
	if (UART_DR = '0') then
          if (DEC_READY = '0') then
	    if (DEC_ERROR = '0') then	 
            PresentState <= ST9;
            end if;
          end if; 
        end if;   
       
	if (UART_DR = '0') then
          if (DEC_READY = '1') then
            if (DEC_ERROR = '0') then 
            PresentState <= ST12;
            end if;
          end if;
        end if;

	if (DEC_ERROR = '1') then
          PresentState <= IDLE;
        end if;

  when ST12 => PresentState <= IDLE;

  when others => PresentState <= RESET;

end case;
end if;

end process StateUpdating;

OutputEvaluation : process (PresentState) is
begin




FF_LE <= '1';
FF_RST <= '0';

DEC_EN <= '0';

REG_LE_GAIN <= '0';
REG_LE_DECAY <= '0';
REG_LE_DELAY_H <= '0';
REG_LE_DELAY_L <= '0';
REG_RST <= '0';

case PresentState is 

  when RESET =>
     
     REG_RST <= '1';
     FF_RST <= '1'; 
  
  when IDLE =>
  
      FF_RST <= '1'; 

  when ST0 =>
 
     FF_LE <= '0';

  when ISTR =>

     FF_LE <= '0';

  when GAIN =>
    
       

  when DECAY =>   

         

  when DELAY => 

 
  when ST1 =>
    
     FF_LE <= '0';
 
  when ST2 =>   

     FF_LE <= '0';      

  when ST3 => 

     FF_LE <= '0';

  when ST4 =>

     FF_LE <= '0';
     DEC_EN <= '1';
  
  when ST5 =>

     FF_LE <= '0';
     DEC_EN <= '1';

  when ST6 =>

     FF_LE <= '0';
     DEC_EN <= '1';

  when ST7 =>

     REG_LE_GAIN <= '1';

  when ST8 =>

     REG_LE_DECAY <= '1';

  when ST9 =>

     REG_LE_DELAY_H <= '1';

  when ST10 =>

     FF_LE <= '0';

  when ST11 =>

     FF_LE <= '0';
     DEC_EN <= '1';
  
  when ST12 => 

      REG_LE_DELAY_L <= '1';  
	 

end case;

end process;

end Behavior;

