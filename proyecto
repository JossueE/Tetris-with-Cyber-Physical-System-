LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY proyecto IS
	PORT (
		clk, reset : IN STD_LOGIC;
		accion, clav_suave : IN STD_LOGIC;
		rx : IN STD_LOGIC;
		tx : OUT STD_LOGIC;
		segments0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		segments1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		leds : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		hs, vs : OUT STD_LOGIC;
		r, g, b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY proyecto;

ARCHITECTURE structural OF proyecto IS

	-- decoder de hexadecimal a 7 segmentos
	COMPONENT DECODERc
		PORT (
			hex : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;
	-- divisor de frecuencia
	COMPONENT divisorfrgeneric
		GENERIC (
			pulsos : INTEGER := 50000000
		);
		PORT (
			clk : IN STD_LOGIC;
			divclk : OUT STD_LOGIC
		);
	END COMPONENT;
	-- envio de comunicacion
	COMPONENT serial_comunication
		PORT (
			clk9600 : IN STD_LOGIC;
			instruccion : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			tx : OUT STD_LOGIC
		);
	END COMPONENT;
	-- recepcion de comunicacion
	COMPONENT serial_reception
		PORT (
			clk9600 : IN STD_LOGIC;
			rx : IN STD_LOGIC;
			llegada : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	-- SENAL DE NUEVOS RELOJS
	SIGNAL clk9600 : STD_LOGIC;

	-- SENAL DE HEXADECIMAL DE LLEGADA
	SIGNAL llegada : STD_LOGIC_VECTOR(7 DOWNTO 0);

	-- ANALOG DIGITAL CONVERTER
	SIGNAL direccion, rotacion, s2, s3, s4, s5, s6, s7 : STD_LOGIC_VECTOR(11 DOWNTO 0);

	COMPONENT miADC2
		PORT (
			CLOCK : IN STD_LOGIC := '0';
			CH0 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			CH1 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			CH2 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			CH3 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			CH4 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			CH5 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			CH6 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			CH7 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
			RESET : IN STD_LOGIC := '0'
		);
	END COMPONENT;

	-- SENAL DE INSTRUCCION
	SIGNAL instruccion : STD_LOGIC_VECTOR(7 DOWNTO 0);
	-- ASIGNADOR DE INSTRUCCION
	COMPONENT asig_instruccion
		PORT (
			direccion, rotacion : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			accion, clav_suave : IN STD_LOGIC;
			instruccion : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	-- VGA
	COMPONENT VGA_Tetris
		PORT (
			opcion : STD_LOGIC_VECTOR(7 DOWNTO 0);
			CLK : IN STD_LOGIC;
			HS, VS : OUT STD_LOGIC;
			R, G, B : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

BEGIN

	-- divisor de frecuencia 9600Hz
	divisor : divisorfrgeneric GENERIC MAP(2605) PORT MAP(clk, clk9600);

	-- ADC
	adc : miADC2 PORT MAP(clk, direccion, rotacion, s2, s3, s4, s5, s6, s7, NOT reset);

	-- asignacion de instruccion
	asig : asig_instruccion PORT MAP(direccion, rotacion, clav_suave, accion, instruccion);

	-- envio de comunicacion
	envio : serial_comunication PORT MAP(clk9600, instruccion, tx);

	-- recepcion de comunicacion
	recepcion : serial_reception PORT MAP(clk9600, rx, llegada);
	leds(7 DOWNTO 0) <= instruccion;
	leds(8) <= clav_suave;
	leds(9) <= accion;

	-- VGA PROXIMA PIEZA, START Y GAME OVER
	vga : VGA_Tetris PORT MAP(llegada, clk, hs, vs, r, g, b);

	-- decoders de hexadecimal a 7 segmentos
	decoder0 : DECODERc PORT MAP(llegada(3 DOWNTO 0), segments0);
	decoder1 : DECODERc PORT MAP(llegada(7 DOWNTO 4), segments1);

END structural;
