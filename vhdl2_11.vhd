LIBRARY IEEE;
USE ieee.std_logic_1164.all;

 ENTITY vhdl2_11 IS
  PORT
  (
  habilita	: IN	BIT; 
  entrada	: IN	BIT;
  dado  	: OUT	BIT; 
  clk   	: IN	BIT  
  );
  END vhdl2_11;

  ARCHITECTURE comportamento OF VHDL2_11 IS
  BEGIN
    PROCESS
     BEGIN	
		WAIT UNTIL clk'event and clk='1';
		IF (habilita = '1') THEN
			dado <= not entrada;
		END IF;
     END PROCESS;
  END comportamento;

