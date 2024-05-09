LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DECODERc IS
	PORT (
		-- Entrada de 4 bits que representa un número hexadecimal
		hex : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		-- Salida de 7 bits que representa el número en notación de 7 segmentos
		seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END ENTITY DECODERc;

ARCHITECTURE concurrent OF DECODERc IS
BEGIN
	seg <= "1000000" WHEN hex = "0000" ELSE
		"1111001" WHEN hex = "0001" ELSE
		"0100100" WHEN hex = "0010" ELSE
		"0110000" WHEN hex = "0011" ELSE
		"0011001" WHEN hex = "0100" ELSE
		"0010010" WHEN hex = "0101" ELSE
		"0000010" WHEN hex = "0110" ELSE
		"1111000" WHEN hex = "0111" ELSE
		"0000000" WHEN hex = "1000" ELSE
		"0010000" WHEN hex = "1001" ELSE
		"0001000" WHEN hex = "1010" ELSE
		"0000011" WHEN hex = "1011" ELSE
		"1000110" WHEN hex = "1100" ELSE
		"0100001" WHEN hex = "1101" ELSE
		"0000110" WHEN hex = "1110" ELSE
		"0001110" WHEN hex = "1111" ELSE
		"1111111";
END concurrent;
