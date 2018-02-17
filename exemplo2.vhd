library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity exemplo2 is
port(
	clk			: in std_logic;					-- clock
	updown		: in std_logic;					-- define se a contagem � up ou down
	contagem	: out integer range 0 to 255	-- saida da contagem
	);
end exemplo2;

architecture arq_exemplo of exemplo2 is

-- declara��o de SIGNAL, PROCEDURE ou FUNCTION

	signal conta : integer range 0 to 255;		-- signal para ser usado com

	procedure incdec is							-- declara��o do PROCEDURE
		begin
			if(updown='1') then					-- if updown = 1 ent�o
				conta <= conta + 1;				-- contagem crescente
			else								-- sen�o
				conta <= conta - 1;				-- contagem decrescente
			end if;
		end incdec;

	begin

	process(clk)

-- declara��o de VARIABLE, PROCEDURE ou FUNCTION
	
		begin									-- in�cio do processo
		
			if(clk'event and clk='1') then		-- borda de subida
				incdec;							-- chamada da PROCEDURE incdec
				contagem <= conta;				-- os pinos de saida recebem o 
			end if;								-- valor do SIGNAL conta

	end process;
end arq_exemplo;
	
