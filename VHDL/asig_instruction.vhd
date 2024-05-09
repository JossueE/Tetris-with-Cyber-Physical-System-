library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY comp_senal IS
	PORT(
		direccion, rotacion : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		accion, clav_suave : IN STD_LOGIC;
		instruccion : OUT character
	);
END comp_senal;

ARCHITECTURE behav OF comp_senal IS
BEGIN

	direccion_int <= 

	instruccion <= 'A' WHEN accion = '1' ELSE
						'a' WHEN clav_suave = '1' ELSE
						'i' WHEN TO_INTEGER(UNSIGNED(direccion)) < 1365 ELSE  --pot < 1/3 entonces izq
						'd' WHEN TO_INTEGER(UNSIGNED(direccion)) > 2730 ELSE	--pot > 2/3 entonces der
						'I' WHEN TO_INTEGER(UNSIGNED(rotacion)) < 1365 ELSE  --pot < 1/3 entonces izq
						'D' WHEN TO_INTEGER(UNSIGNED(rotacion)) > 2730 ELSE	--pot > 2/3 entonces der
						'u';
END behav;
