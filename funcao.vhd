library ieee;
use ieee.std_logic_1164.all;

entity funcao is
port(
	clock : in std_logic;
	opcode : in integer range 0 to 3;
	operando1 : in integer range 0 to 31;
	operando2 : in integer range 0 to 31;
	resultado : out integer range 0 to 63
	);
end funcao;

architecture arq_func of funcao is

function soma (oper_1, oper_2: in integer range 0 to 31) return integer is
	begin
		return oper_1 + oper_2;
end soma;


function subtr(	oper_1: in integer range 0 to 31; 
				oper_2: in integer range 0 to 31) return integer is
	begin
		return oper_1 - oper_2;
end subtr; 

function mult(oper_1: in integer range 0 to 31) return integer is
	begin
		return oper_1 * 2;
end mult;

begin

	process(clock)
		begin
			if(clock'event and clock='1') then
				if(opcode = 0) then
					resultado <= soma(operando1,operando2);
				elsif(opcode = 1) then
					resultado <= subtr(operando1,operando2);
				elsif(opcode = 2) then
					resultado <= mult(operando1);
				else
					resultado <= 63;
				end if;
			end if;
	end process;
end arq_func;
