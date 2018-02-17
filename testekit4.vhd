--------------------------------------------------
-- TESTE DO KIT DIGITAL - EPM 3064ALC44-10
--       PROF. ANDERSON ROYES TERROSO
--             PUCRS 
--------------------------------------------------
-- DECLARACAO DAS BIBLIOTECAS 
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--------------------------------------------------
-- DECLARACAO DA ENTIDADE 
--------------------------------------------------
entity testekit4 is 
port (
  	clock	: in std_logic;
  	reset	: in std_logic;
  	stop	: in std_logic;
  	buzina	: in std_logic;
	updown	: in std_logic;
	dig0	: out std_logic_vector(6 downto 0);
	dig1	: out std_logic_vector(6 downto 0);
	buzzer	: out std_logic
);
end testekit4;
--------------------------------------------------
architecture arq_testekit of testekit4 is
signal clock2 : std_logic;
signal unid : integer range 0 to 9;
signal dez : integer range 0 to 5;

begin
--------------------------------------------------
-- ESTE PROCESSO EH RESPONSAVEL EM REDUZIR A FREQ.
-- POIS ALGUNS TESTES MOSTRARAM QUE FREQ. PEQUENAS
-- COMO 1Hz A FPGA  PERDE A  SINCRONIA  E ACABA SE
-- PERDENDO NA  EXECUCAO.  PORTANTO, A  SOLUCAO EH 
-- COLOCAR UM CLOCK  EXTERNO  COM  UMA  FREQ. MAIS 
-- ELEVADA E DIVIDI-LA INTERNAMENTE.
--------------------------------------------------
divisor: process(clock)
	variable contador: integer range 0 to 7;
	begin
	if(clock'event and clock='1') then
		if(contador =7) then
			clock2 <= '0';
			contador := 0;
		else
			clock2 <= '1';
			contador := contador + 1;
		end if;
	end if;
end process divisor;
		
-------------------------------------------------------
-- O PROCESSO  PRINCIPAL  DESTE  PROGRAMA ESTA DESCRITO
-- ABAIXO . NESTE  PROCESSO  ESTAO  DESCRITOS  ALGUMAS 
-- SUBROTINAS QUE DESCREVEM O FUNCIONAMENTO DO PROG.
-- A SEGUIR SERA COMENTADO CADA UMA DESSAS SUB-ROTINAS.
-------------------------------------------------------
display: process(clock2)
 
-------------------------------------------------------
-- A FUNCAO  DISPLAY  QUANDO CHAMADA CONVERTE UM NUMERO
-- DECIMAL EM UM VETOR DE BITS QUE CORRESPONDE AOS SETE
-- SEGMENTOS DO DISPLAY. O OBJETIVO  DE USAR UMA FUNCAO
-- PARA FAZER ESTA DECODIFICACAO  EH PORQUE AO INVES DE 
-- TERMOS DUAS, UMA PARA CADA DISPLAY, TEMOS APENAS UMA
-- QUE SERA CHAMADA CADA VEZ QUE NECESSITAR UMA DECODIF.
-- USO DA FUNCTION:
-- FUNCTION <NOME> (DECLARACAO DOS PARAMETROS DE ENTRADA
-- DA FUNCAO) RETURN <O TIPO DE RETORNO - INTEIRO, VETOR
-- DE BITS, ETC...> IS
-- DECLARACAO DE UMA VARIAVEL INTERNA
-- BEGIN
-- USO DO COMANDO CASE - DECODIFICACAO
-- RETURN <VARIAVEL> -> INDICA QUE A FUNCAO ESTA RETORNA
-- UM VETOR DE BITS QUE CORRESPONDE AOS SETE SEGMENTOS
-- DO DISPLAY.
-- END <NOME DA FUNCAO> -> FINALIZA A FUNCAO
-------------------------------------------------------
	
	function display (valordig : integer range 0 to 9) return std_logic_vector is
		variable digito : std_logic_vector (6 downto 0);
	begin
		case valordig is	
			when 0 => digito := "0111111";
			when 1 => digito := "0000110";
			when 2 => digito := "1011011";
			when 3 => digito := "1001111";
			when 4 => digito := "1100110";
			when 5 => digito := "1101101";
			when 6 => digito := "1111101";
			when 7 => digito := "0000111";
			when 8 => digito := "1111111";
			when 9 => digito := "1101111";
		end case;
		return digito;
	end display;

-------------------------------------------------------
-- PROCEDURE: EH UMA SUBROTINA ONDE NAO EXISTE PASSAGEM 
-- DE PARAMETRO, DIFENTE DA FUNCAO. NA PROCEDURE TODAS 
-- AS  VARIAVEIS  DEVEM  SER  DO  TIPO SIGNAL, OU SEJA, 
-- GLOBAIS A TODOS OS PROCESSOS. 
-- A PROCEDURE  FUNC_STOP  EH  RESPONSAVEL  EM  PARAR A 
-- CONTAGEM. QUANDO O PUSHBUTTON FOR PRESSIONADO, ENTAO
-- UNID E DEZ, PERMANECEM COM O MESMO VALOR.
-------------------------------------------------------
procedure func_stop is
 begin
	if (stop = '1') then
		unid <= unid;
		dez <= dez;
	end if;
end func_stop;

-------------------------------------------------------
-- A  PROCEDURE FUNC_CONTA_UP FAZ A CONTAGEM CRESCENTE. 
-- COMO O  NIVEL LOGICO DESTE  "PUSH BUTTON" QUANDO NAO 
-- ESTA  PRESSIONADO  EH  ZERO, ENTAO ELE SEMPRE FARA A 
-- CONTAGEM CRESCENTE, MAS  QUANDO PRESSIONADO ELE FARA 
-- A CONTAGEM DOWN.
-------------------------------------------------------
procedure func_conta_up is
begin
	if(unid=9) then
		unid <= 0;
		if(dez=5) then
			dez <= 0;
		else
			dez <= dez + 1;
		end if;
	else
		unid <= unid + 1;
	end if;
end func_conta_up;


-------------------------------------------------------
-- A PROCEDURE FUNC_CONTA_DOWN FAZ A CONTAGEM DECRESCENTE. 
-- COMO  O  NIVEL  LOGICO  DESTE  BOTAO  QUANDO NAO ESTA 
-- PRESSIONADO EH ZERO, ENTAO ELE SEMPRE FARA A CONTAGEM 
-- CRESCENTE, MAS SE PRESSIONADO FARA A CONTAGEM DOWN.
-------------------------------------------------------
procedure func_conta_down is
 begin
	if(unid=0) then
		unid <= 9;
		if(dez = 0) then
			dez <= 5;
		else
			dez <= dez-1;
		end if;
	else
		unid <= unid-1;
	end if;
end func_conta_down;


-------------------------------------------------------
-- A PROCEDURE  FUNC_RESET RESETA A CONTAGEM SEMPRE QUE 
-- O "PUSH BUTTON"  EH  PRESSIONADO, ZERANDO OS VALORES 
-- DA UNID E DEZ.
-------------------------------------------------------
procedure func_reset is
begin
	if(reset = '1') then
		unid <= 0;
		dez <= 0;
	end if;
end func_reset;


-------------------------------------------------------
-- A PROCEDURE FUNC_BUZINA ACIONA A BUZINA SEMPRE QUE O
-- "PUSH BUTTON" BUZINA EH PRESSIONADO.
-------------------------------------------------------
procedure func_buzina is
begin
	if(buzina = '1') then
		buzzer <= '0';
	else
		buzzer <= '1';
	end if;
end func_buzina;

-----------------------------------------------------------------------
--        ROTINA PRINCIPAL QUE CHAMA A FUNCTION E AS PROCEDURES.     --
-----------------------------------------------------------------------
-- INICIO DA LOGICA:
--	SE O PUSH BUTTON STOP NAO ESTA PRESSIONADO ENTAO
--		VERIFICA SE O PUSH BUTTON RESET NAO ESTA PRESSIONADO ENTAO
--			VERIFICA SE O PUSH BUTTON UPDOWN NAO ESTA PRESSIONADO ENTAO
--				FAZ CHAMA A PROCEDURETE FUNC_CONTA_UP E FUNC_BUZINA
--			SE O PUSH BUTTON UPDOWN ESTA PRESSIONADO, ENTAO CHAMA A 
--				FUNC_CONTA_DOWN
--		SE O PUSH BUTTON RESET ESTA PRESSIONADO, ENTAO CHAMA A 
--			FUNC_RESET 
--	SE O PUSH BUTTON STOP ESTA PRESSIONADO ENTAO CHAMA A 
--		FUNC_STOP
-- FIM DA LOGICA.
------------------------------------------------------------------------

BEGIN
	IF(clock2='1') THEN
		buzzer <= '1';
		if(stop = '0') then
			if(reset = '0') then
				if(updown = '0') then
					func_conta_up;
					func_buzina;
				else
					func_conta_down;
				end if;
			else
				func_reset;
			end if;
		else
			func_stop;
		end if;

-------------------------------------------------------
-- CHAMADA  DA  FUNCAO  DISPLAY  E  PASSAGEM DOS SINAIS
-- GLOBAIS  UNID  E  DEZ. O RETORNO DESSA FUNCAO TEM-SE
-- UM VETOR DE BITS QUE CORRESPONDE AOS SETE SEGMENTOS.
-------------------------------------------------------
		dig0 <= display(unid);
		dig1 <= display(dez);

	end if;
--------------------------------------------------------------
-- OBS.: A ESCOLHA POR FUNCTION E PROCEDURE  DEVE-SE  AO  FATO  
-- QUE  O  CONSUMO  DE LB (LOGIC BLOCK) EH MUITO  MENOR  QUE O
-- USO DE LOOP IF ENCADEADO. ESTE  PROGRAMA  CONSUMIU 32 LB's, 
-- ENQUANTO  QUE  O  MESMO  PROGRAMA , EXCETO  AS  ROTINAS  DE 
-- DOWN DA DEZENA E BUZINA OCUPARAM   62  LB'S . O USO DE IF'S 
-- ENCADEADOS REALMENTE  A  NIVEL  DE "HW"  OCUPA  MAIS PORTAS 
-- LOGICAS DO QUE A FORMA QUE FOI IMPLEMENTADO, ALEM  DO MAIS, 
-- FICA MAIS FACIL DE COMPREENDER O  FUNCIONAMENTO DO PROGRAMA
-- DESCRITO POR UMA OUTRA PESSOA.
--------------------------------------------------------------
--                      ** DEVICE SUMMARY **
--
--Chip/             Input Output Bidir     Shareable
--POF  Device       Pins  Pins   Pins  LCs Expanders %Utilized
--
--testekit4
--EPM3064ALC44-10   5     15     0     32     22        50 %
--
--User Pins:               5     15    0
--------------------------------------------------------------
end process display;
end arq_testekit;
