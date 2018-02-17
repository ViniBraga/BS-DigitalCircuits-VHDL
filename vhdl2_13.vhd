 ENTITY vhdl2_13 IS
  PORT
  (
  dado_A	: IN	BIT_VECTOR (7 downto 0);  -- dados de entrada A
  dado_B	: IN	BIT_VECTOR (7 downto 0);  -- dados de entrada B
  and_SAI	: OUT   BIT_VECTOR (7 downto 0)   -- saída das portas
  );
  END vhdl2_13;

  ARCHITECTURE comportamento OF VHDL2_13 IS
  BEGIN
	G1: FOR I IN 0 to 7 GENERATE  -- comando generate exige um label
			and_SAI(I) <= dado_A(I) and dado_B(I);
		END GENERATE;

  END comportamento;


