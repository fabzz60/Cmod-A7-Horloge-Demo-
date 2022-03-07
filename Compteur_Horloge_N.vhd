library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

entity Compteur_pour_HN is
    Port ( CLK : in  STD_LOGIC;  --12MHz
         Reset : in  STD_LOGIC;
         Full : out  STD_LOGIC;
         Empty : out  STD_LOGIC;
         avance_rapide : in  STD_LOGIC;
	 retour_rapide : in  STD_LOGIC;
	 RX_DV : in  STD_LOGIC;
	 Leds_etat_1s : out  STD_LOGIC_VECTOR (3 downto 0);
	 Rx_data_Uart : in  STD_LOGIC_VECTOR (7 downto 0);
         BCD_U : out  STD_LOGIC_VECTOR (3 downto 0);
         BCD_D : out  STD_LOGIC_VECTOR (3 downto 0);
         BCD_M : out  STD_LOGIC_VECTOR (3 downto 0);
         BCD_T : out  STD_LOGIC_VECTOR (3 downto 0);
         BCD_DM : out  STD_LOGIC_VECTOR (3 downto 0);
         BCD_CM : out  STD_LOGIC_VECTOR (3 downto 0));

end Compteur_pour_HN;

architecture Behavioral of Compteur_pour_HN is
--déclaration des signaux et des variables
signal count1: INTEGER range 0 to 100000 := 0;
SIGNAL clock_int1: STD_LOGIC :='0';
signal count2: INTEGER range 0 to 100000 := 0;
SIGNAL clock_int2: STD_LOGIC :='0';
signal count3: INTEGER range 0 to 100000000 := 0;
SIGNAL clock_int3: STD_LOGIC :='0';
CONSTANT M1: INTEGER := 12000; --1000Hz
CONSTANT M2: INTEGER := 12000; --1000Hz
CONSTANT M3: INTEGER := 12000000; --1Hz
-- define the new type for the 3x8 octets RAM 
type RAM_ARRAY is array (0 to 5) of std_logic_vector (7 downto 0);
signal RST_RAM : STD_LOGIC;
signal start_horloge : STD_LOGIC;
signal RAM_ADDR: STD_LOGIC_VECTOR (2 downto 0); -- Address to write/read RAM
-- initial values in the RAM
signal RAM: RAM_ARRAY :=(
   x"00",x"00",x"00",x"00",x"00",x"00"
   );
signal COUNTER_U: INTEGER range 0 to 9;	
signal COUNTER_D: INTEGER range 0 to 5;
signal COUNTER_M: INTEGER range 0 to 9;	
signal COUNTER_T: INTEGER range 0 to 5;
signal COUNTER_DM: INTEGER range 0 to 9;
signal COUNTER_CM: INTEGER range 0 to 2;
signal IS_235959: STD_LOGIC;
signal IS_000000: STD_LOGIC;
signal Synchro_horloge : STD_LOGIC;

begin
-- definition des fréquences utiles -1KHz - 1Hz par défaut. 3 divisions de fréquences à partir du 12MHz
PROCESS
BEGIN
WAIT UNTIL CLK'EVENT and CLK = '1' ;
      IF count1 <= M1-1 THEN  
      count1 <= count1 + 1;
      ELSE
      count1 <= 0;
      END IF;
      --à la moitié du comptage on change la valeur de clock_1Hz_int (rapport cyclique = 1/2)
      IF count1 <= M1/2 THEN
      clock_int1 <= '1';
      ELSE
      clock_int1 <= '0';
      end if;
	
      IF count2 <= M2-1 THEN  
      count2 <= count2 + 1;
      ELSE
      count2 <= 0;
      END IF;
      --à la moitié du comptage on change la valeur  (rapport cyclique = 1/2)
      IF count2 <= M2/2 THEN
      clock_int2 <= '1';
      ELSE
      clock_int2 <= '0';
      end if;
		
      IF count3 <= M3-1 THEN  
      count3 <= count3 + 1;
      ELSE
      count3 <= 0;
      END IF;
      --à la moitié du comptage on change la valeur  (rapport cyclique = 1/2)
      IF count3 <= M3/2 THEN
      clock_int3 <= '1';
      ELSE
      clock_int3 <= '0';
      end if;
END PROCESS;


--reglage horloge suivant état des boutons et fréquence par défaut = 1Hz
process(clock_int1,clock_int2,clock_int3,avance_rapide,retour_rapide)
begin
if avance_rapide ='1' then
   Synchro_horloge <= clock_int1;
	  
elsif retour_rapide ='1' then
   Synchro_horloge <= clock_int2;
  
else
   Synchro_horloge <= clock_int3;
end if;
end process; 

-- visu Leds rouges synchronisation 1Hz
Leds_etat_1s <="1111" when clock_int3 ='1' else "0000";

-- process recupération des données USB-sérial
process(RX_DV,reset,RST_RAM)
begin
if reset ='1' or RST_RAM ='1' then
   RAM_ADDR <="000";
   RAM(0) <=X"00";
   RAM(1) <=X"00";
   RAM(2) <=X"00";
   RAM(3) <=X"00";
   RAM(4) <=X"00";
   RAM(5) <=X"00";
elsif rising_edge(RX_DV) then
  if Rx_data_uart>= X"30" and Rx_data_uart <= X"39" then
      IF RAM_ADDR <=6 THEN
       RAM_ADDR <= RAM_ADDR + 1;
	    RAM(to_integer(unsigned(RAM_ADDR))) <= Rx_data_uart(7 downto 0)- X"30";
	   ELSE
	    RAM_ADDR <="000";
		 RAM(to_integer(unsigned(RAM_ADDR))) <= "00000000";	
	   END IF;
   end if;
	if start_horloge ='1' then 
	   RAM_ADDR <="000";
	end if;
end if;
end process;

RST_RAM <='1' when Rx_data_uart = X"72" else '0'; -- r du clavier
start_horloge <='1' when Rx_data_uart = X"0D" else '0'; -- touche entrée start horloge.

--compteur décompteur pour 6 afficheurs 7 segments
process(Synchro_horloge,Reset,RST_RAM,RAM_ADDR)
begin
if reset ='1' or RST_RAM ='1' then
      COUNTER_U  <= 0;
      COUNTER_D  <= 0;
      COUNTER_M  <= 0;
      COUNTER_T  <= 0;
	  COUNTER_DM <= 0;
	  COUNTER_CM <= 0;		
elsif Synchro_horloge'event and Synchro_horloge ='1' then
	 if avance_rapide ='0' and retour_rapide = '0' then
	    if IS_235959 = '0' then 
	       if COUNTER_U = 9 then
	     	  COUNTER_U <= 0;
	       if COUNTER_D = 5 then
                  COUNTER_D <= 0;
               if COUNTER_M = 9 then
                  COUNTER_M <= 0;
               if COUNTER_T = 5 then
                  COUNTER_T <= 0;
	       if COUNTER_DM = 9 then
                  COUNTER_DM <= 0;
	       if COUNTER_CM = 2 then
                  COUNTER_CM <= 0;
               else
               COUNTER_CM <= COUNTER_CM + 1;
               end if; 
	       else
               COUNTER_DM <= COUNTER_DM + 1;
               end if; 
               else
               COUNTER_T <= COUNTER_T + 1;
               end if; 
               else
               COUNTER_M <= COUNTER_M + 1;
               end if;  
               else
               COUNTER_D <= COUNTER_D + 1;
               end if;
               else
               COUNTER_U <= COUNTER_U + 1;
               end if;
             end if;
	end if;
    if  avance_rapide ='1' and retour_rapide = '0' then 
	  if IS_235959 = '0' then 
	       if COUNTER_U = 9 then
	     	  COUNTER_U <= 0;
	       if COUNTER_D = 5 then
                  COUNTER_D <= 0;
               if COUNTER_M = 9 then
                  COUNTER_M <= 0;
               if COUNTER_T = 5 then
                  COUNTER_T <= 0;
	       if COUNTER_DM = 9 then
                  COUNTER_DM <= 0;
	       if COUNTER_CM = 2 then
                  COUNTER_CM <= 0;
	       else
               COUNTER_CM <= COUNTER_CM + 1;
               end if; 
	       else
               COUNTER_DM <= COUNTER_DM + 1;
               end if; 
               else
               COUNTER_T <= COUNTER_T + 1;
               end if; 
               else
               COUNTER_M <= COUNTER_M + 1;
               end if;  
               else
               COUNTER_D <= COUNTER_D + 1;
               end if;
               else
               COUNTER_U <= COUNTER_U + 1;
               end if;
             end if;
	end if;
      if retour_rapide = '1' and  avance_rapide = '0' then
           if IS_000000 = '0' then 
	       if COUNTER_U = 0 then
	          COUNTER_U <= 9;
	       if COUNTER_D = 0 then
                  COUNTER_D <= 5;
               if COUNTER_M = 0 then
                  COUNTER_M <= 9;
               if COUNTER_T = 0 then
                  COUNTER_T <= 5;
	       if COUNTER_DM = 0 then
                  COUNTER_DM <= 9;
	       if COUNTER_CM = 0 then
                  COUNTER_CM <= 2;
	       else
               COUNTER_CM <= COUNTER_CM - 1;
               end if; 
	       else
               COUNTER_DM <= COUNTER_DM - 1;
               end if; 
               else
               COUNTER_T <= COUNTER_T - 1;
               end if; 
               else
               COUNTER_M <= COUNTER_M - 1;
               end if;  
               else
               COUNTER_D <= COUNTER_D - 1;
               end if;
               else
               COUNTER_U <= COUNTER_U - 1;
               end if;
             end if;
      end if;			
                if IS_235959 = '1' then 	
                COUNTER_U  <= 0;
                COUNTER_D  <= 0;
                COUNTER_M  <= 0;
                COUNTER_T  <= 0;
		COUNTER_DM <= 0;
		COUNTER_CM <= 0;	
		end if;
					 
                if RAM_ADDR = 6 then 	
                COUNTER_U  <= to_integer(unsigned(RAM(5)));
                COUNTER_D  <= to_integer(unsigned(RAM(4)));
                COUNTER_M  <= to_integer(unsigned(RAM(3)));
                COUNTER_T  <= to_integer(unsigned(RAM(2)));
		COUNTER_DM <= to_integer(unsigned(RAM(1)));
		COUNTER_CM <= to_integer(unsigned(RAM(0)));
		end if;
 
end if;
end process;
   
	BCD_U <= std_logic_vector(to_unsigned(COUNTER_U,4));
	BCD_D <= std_logic_vector(to_unsigned(COUNTER_D,4));
	BCD_M <= std_logic_vector(to_unsigned(COUNTER_M,4));
	BCD_T <= std_logic_vector(to_unsigned(COUNTER_T,4));
	BCD_DM <= std_logic_vector(to_unsigned(COUNTER_DM,4));
	BCD_CM <= std_logic_vector(to_unsigned(COUNTER_CM,4));
	
 --définition des bornes de l'horloge numérique 
 IS_235959 <= '1' when (COUNTER_U = 0 and COUNTER_D = 0 and COUNTER_M = 0 and COUNTER_T = 0 and COUNTER_DM = 4 and COUNTER_CM = 2) else '0';
 IS_000000 <= '1' when (COUNTER_U = 0 and COUNTER_D = 0 and COUNTER_M = 0 and COUNTER_T = 0 and COUNTER_DM = 0 and COUNTER_CM = 0) else '0';
 --visu led lorsque le compteur atteint 23h59h59s et 00:00:00
 Full <= IS_235959; 
 Empty <= IS_000000;
end Behavioral;
