-- ******************************************
-- circuito: somador de N bits:
--						uso do comando FOR
-- ******************************************
 
 ENTITY vhdl2_9 IS
  PORT
  (
  dado_A	: IN	BIT_VECTOR (7 downto 0);  
  dado_B	: IN	BIT_VECTOR (7 downto 0);  
  saida		: OUT   BIT_VECTOR (7 downto 0)  
  );

  END vhdl2_9;

  ARCHITECTURE comportamento OF VHDL2_9 IS
  BEGIN
    PROCESS (dado_A, dado_B)	
     BEGIN						
		FOR I IN 0 to 7 LOOP
			IF I=0 THEN
				saida(I) <= dado_A(I) xor dado_B(I);
			ELSE 
				saida(I) <= dado_A(I) and dado_B(I);
			END IF;
		END LOOP;
     END PROCESS;
  END comportamento;



