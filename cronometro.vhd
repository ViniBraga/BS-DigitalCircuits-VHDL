LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_unSIGNED.ALL;

ENTITY cronometro IS
PORT(
	dig0	: out std_logic_vector(6 downto 0);
	dig1	: out std_logic_vector(6 downto 0);
	clk	    : IN STD_LOGIC
	);
END cronometro;

ARCHITECTURE arq_controlador OF cronometro IS

BEGIN

entrada: PROCESS(clk)
	VARIABLE unid : INTEGER RANGE 0 TO 9;
	VARIABLE dez  : INTEGER RANGE 0 TO 5;
	BEGIN
		IF(clk'event and clk='1') THEN
			if(unid = 9) then
				unid := 0;
				if(dez = 5) then
					dez := 0;
				else
					dez := dez + 1;
				end if;
			else
				unid := unid +1;
			end if;


		case unid is
		when 0 => dig0 <= "1001110";
		when 1 => dig0 <= "0101110";
		when 2 => dig0 <= "0011110";
		when 3 => dig0 <= "0001111";
		when 4 => dig0 <= "0001100";
		when 5 => dig0 <= "0001010";
		when 6 => dig0 <= "0000110";
		when 7 => dig0 <= "0011110";
		when 8 => dig0 <= "0101110";
		when 9 => dig0 <= "1001110";
		end case;
		
		case dez is
		when 0 => dig1 <= "1001110";
		when 1 => dig1 <= "0101110";
		when 2 => dig1 <= "0011110";
		when 3 => dig1 <= "0001111";
		when 4 => dig1 <= "0001100";
		when 5 => dig1 <= "0001010";
		end case;

		END IF;
		
END PROCESS entrada;
END arq_controlador;
