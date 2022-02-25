library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity multiplexeur is

    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           C : in  STD_LOGIC_VECTOR (3 downto 0);
           D : in  STD_LOGIC_VECTOR (3 downto 0);
           E : in  STD_LOGIC_VECTOR (3 downto 0);
           F : in  STD_LOGIC_VECTOR (3 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           sortie_mux : out  STD_LOGIC_VECTOR (3 downto 0));
			  
end multiplexeur;

architecture Behavioral of multiplexeur is

begin

process(sel,A,B,C,D,E,F)
begin
case  sel is
	  when "000" => Sortie_Mux <= A;
	  when "001" => Sortie_Mux <= B;
	  when "010" => Sortie_Mux <= C;
	  when "011" => Sortie_Mux <= D;
	  when "100" => Sortie_Mux <= E;
	  when "101" => Sortie_Mux <= F;
	  when "110" => Sortie_Mux <= A;
	  when "111" => Sortie_Mux <= A;
	  when others => NULL;
end case;
end process;


end Behavioral;

