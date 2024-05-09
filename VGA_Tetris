LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY VGA_Tetris IS
	PORT (
		opcion : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		CLK : IN STD_LOGIC;
		HS, VS : OUT STD_LOGIC;
		R, G, B : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END VGA_Tetris;

ARCHITECTURE behav OF VGA_Tetris IS

	SIGNAL CLK_25, aux_HS, aux_VS, DH, DV : STD_LOGIC;
	SIGNAL DT : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL x, y : INTEGER;

BEGIN
	HS <= aux_HS;
	VS <= aux_VS;
	PROCESS (CLK) -- Divisor de 25MHz
	BEGIN
		IF rising_edge(CLK) THEN
			CLK_25 <= NOT CLK_25;
		ELSE
			CLK_25 <= CLK_25;
		END IF;
	END PROCESS;

	PROCESS (CLK_25) -- HS
		VARIABLE contador, cont_x : INTEGER := 0;
	BEGIN
		IF rising_edge(CLK_25) THEN
			contador := contador + 1;
			IF (contador < 96) THEN -- Pulse Width
				aux_HS <= '0';
				DH <= '0';
			ELSIF (contador < 96 + 48) THEN -- Back Porch
				aux_HS <= '1';
				DH <= '0';
			ELSIF (contador < 96 + 48 + 640) THEN -- Disp Time
				aux_HS <= '1';
				DH <= '1';
				cont_x := cont_x + 1;
			ELSIF (contador < 96 + 48 + 640 + 16) THEN -- Front Porch
				aux_HS <= '1';
				DH <= '0';
			ELSE
				cont_x := 0;
				contador := 0;
				aux_HS <= '0';
				DH <= '0';
			END IF;
		END IF;
		x <= cont_x;
	END PROCESS;

	PROCESS (aux_HS) -- VS
		VARIABLE cont, cont_y : INTEGER := 0;
	BEGIN
		IF rising_edge(aux_HS) THEN
			cont := cont + 1;
			IF (cont < 2) THEN -- Pulse Width
				aux_VS <= '0';
				DV <= '0';
			ELSIF (cont < 2 + 29) THEN -- Back Porch
				aux_VS <= '1';
				DV <= '0';
			ELSIF (cont < 2 + 29 + 480) THEN -- Disp Time
				aux_VS <= '1';
				DV <= '1'; -- Disp Time VS
				cont_y := cont_y + 1;
			ELSIF (cont < 2 + 29 + 480 + 10) THEN -- Front Porch
				aux_VS <= '1';
				DV <= '0';
			ELSE
				cont_y := 0;
				cont := 0;
				aux_VS <= '1';
				DV <= '0';
			END IF;
		END IF;
		y <= cont_y;
		DT <= DH & DV;
	END PROCESS;

	PROCESS (DT)
	BEGIN
		IF DT = "11" AND opcion = "00000000" THEN
			-- x-x-x-x
			IF (x > 78 AND x < 195 AND y > 178 AND y < 203) OR --1
				(x > 196 AND x < 313 AND y > 178 AND y < 203) OR --2
				(x > 314 AND x < 431 AND y > 178 AND y < 203) OR --3
				(x > 432 AND x < 549 AND y > 178 AND y < 203) OR --4

				(x > 78 AND x < 195 AND y > 270 AND y < 295) OR --1
				(x > 196 AND x < 313 AND y > 270 AND y < 295) OR --2
				(x > 314 AND x < 431 AND y > 270 AND y < 295) OR --3
				(x > 432 AND x < 549 AND y > 270 AND y < 295) OR --3

				(x > 78 AND x < 103 AND y > 202 AND y < 271) OR --1
				(x > 170 AND x < 195 AND y > 202 AND y < 271) OR

				(x > 196 AND x < 221 AND y > 202 AND y < 271) OR --2
				(x > 287 AND x < 313 AND y > 202 AND y < 271) OR

				(x > 314 AND x < 339 AND y > 202 AND y < 271) OR --3
				(x > 406 AND x < 431 AND y > 202 AND y < 271) OR

				(x > 432 AND x < 457 AND y > 202 AND y < 271) OR --4
				(x > 524 AND x < 549 AND y > 202 AND y < 271)

				THEN

				R <= "0000"; -- Rojo
				G <= "0000"; -- Verde
				B <= "0000"; -- Azul

			ELSIF (x > 102 AND x < 127 AND y > 202 AND y < 271) OR --1
				(x > 126 AND x < 171 AND y > 246 AND y < 271) OR --1

				(x > 220 AND x < 245 AND y > 202 AND y < 271) OR --2
				(x > 244 AND x < 289 AND y > 246 AND y < 271) OR --2

				(x > 338 AND x < 363 AND y > 202 AND y < 271) OR --3
				(x > 362 AND x < 407 AND y > 246 AND y < 271) OR --3

				(x > 456 AND x < 481 AND y > 202 AND y < 271) OR --4
				(x > 480 AND x < 525 AND y > 246 AND y < 271) --4

				THEN

				R <= "0101"; -- Rojo
				G <= "0101"; -- Verde
				B <= "0101"; -- Azul

			ELSIF (x > 126 AND x < 148 AND y > 202 AND y < 247) OR --1
				(x > 147 AND x < 171 AND y > 226 AND y < 247) OR --1

				(x > 244 AND x < 266 AND y > 202 AND y < 247) OR --2
				(x > 265 AND x < 289 AND y > 226 AND y < 247) OR --2

				(x > 362 AND x < 384 AND y > 202 AND y < 247) OR --3 
				(x > 383 AND x < 407 AND y > 226 AND y < 247) OR --3

				(x > 480 AND x < 502 AND y > 202 AND y < 247) OR --4
				(x > 501 AND x < 525 AND y > 226 AND y < 247) --4

				THEN
				R <= "0011"; -- Rojo
				G <= "0011"; -- Verde
				B <= "0011"; -- Azul
			ELSE
				R <= "1111"; -- Rojo
				G <= "1111"; -- Verde
				B <= "1111"; -- Azul
			END IF;

		ELSIF DT = "11" AND opcion = "00000001" THEN
			--    x
			--  x x
			--  x

			IF (x > 196 AND x < 313 AND y > 296 AND y < 321) OR --1
				(x > 196 AND x < 313 AND y > 178 AND y < 203) OR --2
				(x > 314 AND x < 431 AND y > 178 AND y < 203) OR --3
				(x > 314 AND x < 431 AND y > 60 AND y < 85) OR --4

				(x > 196 AND x < 313 AND y > 388 AND y < 413) OR --1
				(x > 196 AND x < 313 AND y > 270 AND y < 295) OR --2
				(x > 314 AND x < 431 AND y > 270 AND y < 295) OR --3
				(x > 314 AND x < 431 AND y > 152 AND y < 177) OR --4

				(x > 196 AND x < 221 AND y > 320 AND y < 389) OR --1
				(x > 287 AND x < 313 AND y > 320 AND y < 389) OR

				(x > 196 AND x < 221 AND y > 202 AND y < 271) OR --2
				(x > 287 AND x < 313 AND y > 202 AND y < 271) OR

				(x > 314 AND x < 339 AND y > 202 AND y < 271) OR --3.
				(x > 406 AND x < 431 AND y > 202 AND y < 271) OR

				(x > 314 AND x < 339 AND y > 84 AND y < 153) OR --4
				(x > 406 AND x < 431 AND y > 84 AND y < 153)

				THEN

				R <= "0000"; -- Rojo
				G <= "0000"; -- Verde
				B <= "0000"; -- Azul

			ELSIF (x > 220 AND x < 245 AND y > 320 AND y < 389) OR --1
				(x > 244 AND x < 289 AND y > 364 AND y < 389) OR --1

				(x > 220 AND x < 245 AND y > 202 AND y < 271) OR --2
				(x > 244 AND x < 289 AND y > 246 AND y < 271) OR --2

				(x > 338 AND x < 363 AND y > 202 AND y < 271) OR --3
				(x > 362 AND x < 407 AND y > 246 AND y < 271) OR --3

				(x > 338 AND x < 363 AND y > 84 AND y < 153) OR --4
				(x > 362 AND x < 407 AND y > 128 AND y < 153) --4
				THEN

				R <= "0101"; -- Rojo
				G <= "0101"; -- Verde
				B <= "0101"; -- Azul

			ELSIF (x > 244 AND x < 266 AND y > 320 AND y < 365) OR --1
				(x > 265 AND x < 289 AND y > 342 AND y < 365) OR --1

				(x > 244 AND x < 266 AND y > 202 AND y < 247) OR --2
				(x > 265 AND x < 289 AND y > 226 AND y < 247) OR --2

				(x > 362 AND x < 384 AND y > 202 AND y < 247) OR --3 
				(x > 383 AND x < 407 AND y > 226 AND y < 247) OR --3

				(x > 362 AND x < 384 AND y > 84 AND y < 129) OR --4
				(x > 383 AND x < 407 AND y > 108 AND y < 129) --4

				THEN
				R <= "0011"; -- Rojo
				G <= "0011"; -- Verde
				B <= "0011"; -- Azul
			ELSE
				R <= "1111"; -- Rojo
				G <= "1111"; -- Verde
				B <= "1111"; -- Azul}
			END IF;
		ELSIF DT = "11" AND opcion = "00000010" THEN
			--  x
			--  x x
			--    x	

			IF (x > 196 AND x < 313 AND y > 60 AND y < 85) OR --1
				(x > 196 AND x < 313 AND y > 178 AND y < 203) OR --2
				(x > 314 AND x < 431 AND y > 178 AND y < 203) OR --3
				(x > 314 AND x < 431 AND y > 296 AND y < 321) OR --4

				(x > 196 AND x < 313 AND y > 152 AND y < 177) OR --1
				(x > 196 AND x < 313 AND y > 270 AND y < 295) OR --2
				(x > 314 AND x < 431 AND y > 270 AND y < 295) OR --3
				(x > 314 AND x < 431 AND y > 388 AND y < 413) OR --4

				(x > 196 AND x < 221 AND y > 84 AND y < 153) OR --1
				(x > 287 AND x < 313 AND y > 84 AND y < 153) OR

				(x > 196 AND x < 221 AND y > 202 AND y < 271) OR --2
				(x > 287 AND x < 313 AND y > 202 AND y < 271) OR

				(x > 314 AND x < 339 AND y > 202 AND y < 271) OR --3
				(x > 406 AND x < 431 AND y > 202 AND y < 271) OR

				(x > 314 AND x < 339 AND y > 320 AND y < 389) OR --4
				(x > 406 AND x < 431 AND y > 320 AND y < 389)

				THEN

				R <= "0000"; -- Rojo
				G <= "0000"; -- Verde
				B <= "0000"; -- Azul

			ELSIF (x > 220 AND x < 245 AND y > 84 AND y < 153) OR --1
				(x > 244 AND x < 289 AND y > 128 AND y < 153) OR --1

				(x > 220 AND x < 245 AND y > 202 AND y < 271) OR --2
				(x > 244 AND x < 289 AND y > 246 AND y < 271) OR --2

				(x > 338 AND x < 363 AND y > 202 AND y < 271) OR --3
				(x > 362 AND x < 407 AND y > 246 AND y < 271) OR --3

				(x > 338 AND x < 363 AND y > 320 AND y < 389) OR --4 
				(x > 362 AND x < 407 AND y > 364 AND y < 389) --4 
				THEN

				R <= "0101"; -- Rojo
				G <= "0101"; -- Verde
				B <= "0101"; -- Azul

			ELSIF (x > 244 AND x < 266 AND y > 84 AND y < 129) OR --1
				(x > 265 AND x < 289 AND y > 108 AND y < 129) OR --1

				(x > 244 AND x < 266 AND y > 202 AND y < 247) OR --2
				(x > 265 AND x < 289 AND y > 226 AND y < 247) OR --2

				(x > 362 AND x < 384 AND y > 202 AND y < 247) OR --3 
				(x > 383 AND x < 407 AND y > 226 AND y < 247) OR --3

				(x > 362 AND x < 384 AND y > 320 AND y < 365) OR --4  
				(x > 383 AND x < 407 AND y > 342 AND y < 365) --4 

				THEN
				R <= "0011"; -- Rojo
				G <= "0011"; -- Verde
				B <= "0011"; -- Azul
			ELSE
				R <= "1111"; -- Rojo
				G <= "1111"; -- Verde
				B <= "1111"; -- Azul}
			END IF;

		ELSIF DT = "11" AND opcion = "00000011" THEN
			-- xx
			-- xx

			IF (x > 203 AND x < 320 AND y > 122 AND y < 147) OR --1
				(x > 321 AND x < 438 AND y > 122 AND y < 147) OR --2
				(x > 203 AND x < 320 AND y > 240 AND y < 265) OR --3
				(x > 321 AND x < 438 AND y > 240 AND y < 265) OR --4

				(x > 203 AND x < 320 AND y > 214 AND y < 239) OR --1
				(x > 321 AND x < 438 AND y > 214 AND y < 239) OR --2
				(x > 203 AND x < 320 AND y > 332 AND y < 357) OR --3
				(x > 321 AND x < 438 AND y > 332 AND y < 357) OR --4

				(x > 203 AND x < 228 AND y > 146 AND y < 215) OR --1
				(x > 295 AND x < 320 AND y > 146 AND y < 215) OR

				(x > 321 AND x < 346 AND y > 146 AND y < 215) OR --2
				(x > 413 AND x < 438 AND y > 146 AND y < 215) OR

				(x > 203 AND x < 228 AND y > 264 AND y < 333) OR --3
				(x > 295 AND x < 320 AND y > 264 AND y < 333) OR

				(x > 321 AND x < 346 AND y > 264 AND y < 333) OR --4
				(x > 413 AND x < 438 AND y > 264 AND y < 333)

				THEN

				R <= "0000"; -- Rojo
				G <= "0000"; -- Verde
				B <= "0000"; -- Azul

			ELSIF (x > 227 AND x < 252 AND y > 146 AND y < 215) OR --1
				(x > 251 AND x < 296 AND y > 190 AND y < 215) OR --1

				(x > 345 AND x < 370 AND y > 146 AND y < 215) OR --2
				(x > 369 AND x < 414 AND y > 190 AND y < 215) OR --2

				(x > 227 AND x < 252 AND y > 264 AND y < 333) OR --3
				(x > 251 AND x < 296 AND y > 308 AND y < 333) OR --3

				(x > 345 AND x < 370 AND y > 264 AND y < 333) OR --4
				(x > 369 AND x < 414 AND y > 308 AND y < 333) --4

				THEN

				R <= "0101"; -- Rojo
				G <= "0101"; -- Verde
				B <= "0101"; -- Azul

			ELSIF (x > 251 AND x < 273 AND y > 146 AND y < 191) OR --1
				(x > 272 AND x < 296 AND y > 170 AND y < 191) OR --1

				(x > 369 AND x < 391 AND y > 146 AND y < 191) OR --2
				(x > 390 AND x < 414 AND y > 170 AND y < 191) OR --2

				(x > 251 AND x < 273 AND y > 264 AND y < 309) OR --3 
				(x > 272 AND x < 296 AND y > 288 AND y < 309) OR --3

				(x > 369 AND x < 391 AND y > 264 AND y < 309) OR --4
				(x > 390 AND x < 414 AND y > 288 AND y < 309) --4

				THEN
				R <= "0011"; -- Rojo
				G <= "0011"; -- Verde
				B <= "0011"; -- Azul
			ELSE
				R <= "1111"; -- Rojo
				G <= "1111"; -- Verde
				B <= "1111"; -- Azul}
			END IF;

		ELSIF DT = "11" AND opcion = "00000100" THEN
			--   x
			-- x x
			--   x

			IF (x > 314 AND x < 431 AND y > 60 AND y < 85) OR --1
				(x > 196 AND x < 313 AND y > 178 AND y < 203) OR --2
				(x > 314 AND x < 431 AND y > 178 AND y < 203) OR --3
				(x > 314 AND x < 431 AND y > 296 AND y < 321) OR --4

				(x > 314 AND x < 431 AND y > 152 AND y < 177) OR --1
				(x > 196 AND x < 313 AND y > 270 AND y < 295) OR --2
				(x > 314 AND x < 431 AND y > 270 AND y < 295) OR --3
				(x > 314 AND x < 431 AND y > 388 AND y < 413) OR --4

				(x > 314 AND x < 339 AND y > 84 AND y < 153) OR --1
				(x > 406 AND x < 431 AND y > 84 AND y < 153) OR

				(x > 196 AND x < 221 AND y > 202 AND y < 271) OR --2
				(x > 287 AND x < 313 AND y > 202 AND y < 271) OR

				(x > 314 AND x < 339 AND y > 202 AND y < 271) OR --3
				(x > 406 AND x < 431 AND y > 202 AND y < 271) OR

				(x > 314 AND x < 339 AND y > 320 AND y < 389) OR --4
				(x > 406 AND x < 431 AND y > 320 AND y < 389)

				THEN

				R <= "0000"; -- Rojo
				G <= "0000"; -- Verde
				B <= "0000"; -- Azul

			ELSIF (x > 338 AND x < 363 AND y > 84 AND y < 153) OR --1
				(x > 362 AND x < 407 AND y > 128 AND y < 153) OR --1

				(x > 220 AND x < 245 AND y > 202 AND y < 271) OR --2
				(x > 244 AND x < 289 AND y > 246 AND y < 271) OR --2

				(x > 338 AND x < 363 AND y > 202 AND y < 271) OR --3
				(x > 362 AND x < 407 AND y > 246 AND y < 271) OR --3

				(x > 338 AND x < 363 AND y > 320 AND y < 389) OR --4 
				(x > 362 AND x < 407 AND y > 364 AND y < 389) --4 
				THEN

				R <= "0101"; -- Rojo
				G <= "0101"; -- Verde
				B <= "0101"; -- Azul

			ELSIF (x > 362 AND x < 384 AND y > 84 AND y < 129) OR --1
				(x > 383 AND x < 407 AND y > 108 AND y < 129) OR --1

				(x > 244 AND x < 266 AND y > 202 AND y < 247) OR --2
				(x > 265 AND x < 289 AND y > 226 AND y < 247) OR --2

				(x > 362 AND x < 384 AND y > 202 AND y < 247) OR --3 
				(x > 383 AND x < 407 AND y > 226 AND y < 247) OR --3

				(x > 362 AND x < 384 AND y > 320 AND y < 365) OR --4  
				(x > 383 AND x < 407 AND y > 342 AND y < 365) --4 

				THEN
				R <= "0011"; -- Rojo
				G <= "0011"; -- Verde
				B <= "0011"; -- Azul
			ELSE
				R <= "1111"; -- Rojo
				G <= "1111"; -- Verde
				B <= "1111"; -- Azul}
			END IF;

		ELSIF DT = "11" AND opcion = "00000101" THEN
			--  x x
			--    x
			--    x

			IF (x > 196 AND x < 313 AND y > 60 AND y < 85) OR --1
				(x > 314 AND x < 431 AND y > 178 AND y < 203) OR --2
				(x > 314 AND x < 431 AND y > 60 AND y < 85) OR --3
				(x > 314 AND x < 431 AND y > 296 AND y < 321) OR --4

				(x > 196 AND x < 313 AND y > 152 AND y < 177) OR --1
				(x > 314 AND x < 431 AND y > 270 AND y < 295) OR --2
				(x > 314 AND x < 431 AND y > 152 AND y < 177) OR --3
				(x > 314 AND x < 431 AND y > 388 AND y < 413) OR --4

				(x > 196 AND x < 221 AND y > 84 AND y < 153) OR --1
				(x > 287 AND x < 313 AND y > 84 AND y < 153) OR

				(x > 314 AND x < 339 AND y > 202 AND y < 271) OR --2
				(x > 406 AND x < 431 AND y > 202 AND y < 271) OR

				(x > 314 AND x < 339 AND y > 84 AND y < 153) OR --3
				(x > 406 AND x < 431 AND y > 84 AND y < 153) OR

				(x > 314 AND x < 339 AND y > 320 AND y < 389) OR --4
				(x > 406 AND x < 431 AND y > 320 AND y < 389)

				THEN

				R <= "0000"; -- Rojo
				G <= "0000"; -- Verde
				B <= "0000"; -- Azul

			ELSIF (x > 220 AND x < 245 AND y > 84 AND y < 153) OR --1
				(x > 244 AND x < 289 AND y > 128 AND y < 153) OR --1

				(x > 338 AND x < 363 AND y > 202 AND y < 271) OR --2
				(x > 362 AND x < 407 AND y > 246 AND y < 271) OR --2

				(x > 338 AND x < 363 AND y > 84 AND y < 153) OR --3
				(x > 362 AND x < 407 AND y > 128 AND y < 153) OR --3

				(x > 338 AND x < 363 AND y > 320 AND y < 389) OR --4 
				(x > 362 AND x < 407 AND y > 364 AND y < 389) --4 
				THEN

				R <= "0101"; -- Rojo
				G <= "0101"; -- Verde
				B <= "0101"; -- Azul

			ELSIF (x > 244 AND x < 266 AND y > 84 AND y < 129) OR --1
				(x > 265 AND x < 289 AND y > 108 AND y < 129) OR --1

				(x > 362 AND x < 384 AND y > 202 AND y < 247) OR --2
				(x > 383 AND x < 407 AND y > 226 AND y < 247) OR --2

				(x > 362 AND x < 384 AND y > 84 AND y < 129) OR --3
				(x > 383 AND x < 407 AND y > 108 AND y < 129) OR --3

				(x > 362 AND x < 384 AND y > 320 AND y < 365) OR --4  
				(x > 383 AND x < 407 AND y > 342 AND y < 365) --4 

				THEN
				R <= "0011"; -- Rojo
				G <= "0011"; -- Verde
				B <= "0011"; -- Azul
			ELSE
				R <= "1111"; -- Rojo
				G <= "1111"; -- Verde
				B <= "1111"; -- Azul}
			END IF;
		ELSIF DT = "11" AND opcion = "00000110" THEN
			--  x x
			--  x 
			--  x

			IF (x > 196 AND x < 313 AND y > 60 AND y < 85) OR --1
				(x > 196 AND x < 313 AND y > 178 AND y < 203) OR --2
				(x > 314 AND x < 431 AND y > 60 AND y < 85) OR --3
				(x > 196 AND x < 313 AND y > 296 AND y < 321) OR --4

				(x > 196 AND x < 313 AND y > 152 AND y < 177) OR --1
				(x > 196 AND x < 313 AND y > 270 AND y < 295) OR --2
				(x > 314 AND x < 431 AND y > 152 AND y < 177) OR --3
				(x > 196 AND x < 313 AND y > 388 AND y < 413) OR --4

				(x > 196 AND x < 221 AND y > 84 AND y < 153) OR --1
				(x > 287 AND x < 313 AND y > 84 AND y < 153) OR

				(x > 196 AND x < 221 AND y > 202 AND y < 271) OR --2
				(x > 287 AND x < 313 AND y > 202 AND y < 271) OR

				(x > 314 AND x < 339 AND y > 84 AND y < 153) OR --3
				(x > 406 AND x < 431 AND y > 84 AND y < 153) OR

				(x > 196 AND x < 221 AND y > 320 AND y < 389) OR --4
				(x > 287 AND x < 313 AND y > 320 AND y < 389)

				THEN

				R <= "0000"; -- Rojo
				G <= "0000"; -- Verde
				B <= "0000"; -- Azul

			ELSIF (x > 220 AND x < 245 AND y > 84 AND y < 153) OR --1
				(x > 244 AND x < 289 AND y > 128 AND y < 153) OR --1

				(x > 220 AND x < 245 AND y > 202 AND y < 271) OR --2
				(x > 244 AND x < 289 AND y > 246 AND y < 271) OR --2

				(x > 338 AND x < 363 AND y > 84 AND y < 153) OR --3
				(x > 362 AND x < 407 AND y > 128 AND y < 153) OR --3

				(x > 220 AND x < 245 AND y > 320 AND y < 389) OR --4 
				(x > 244 AND x < 289 AND y > 364 AND y < 389) --4 
				THEN

				R <= "0101"; -- Rojo
				G <= "0101"; -- Verde
				B <= "0101"; -- Azul

			ELSIF (x > 244 AND x < 266 AND y > 84 AND y < 129) OR --1
				(x > 265 AND x < 289 AND y > 108 AND y < 129) OR --1

				(x > 244 AND x < 266 AND y > 202 AND y < 247) OR --2
				(x > 265 AND x < 289 AND y > 226 AND y < 247) OR --2

				(x > 362 AND x < 384 AND y > 84 AND y < 129) OR --3
				(x > 383 AND x < 407 AND y > 108 AND y < 129) OR --3

				(x > 244 AND x < 266 AND y > 320 AND y < 365) OR --4  
				(x > 265 AND x < 289 AND y > 342 AND y < 365) --4 

				THEN
				R <= "0011"; -- Rojo
				G <= "0011"; -- Verde
				B <= "0011"; -- Azul
			ELSE
				R <= "1111"; -- Rojo
				G <= "1111"; -- Verde
				B <= "1111"; -- Azul}
			END IF;

		ELSIF DT = "11" AND opcion = "01000110" THEN -- Game over
			IF (x > 111 AND x < 144 AND y > 205 AND y < 214) OR
				(x > 104 AND x < 120 AND y > 213 AND y < 268) OR
				(x > 111 AND x < 145 AND y > 266 AND y < 276) OR
				(x > 135 AND x < 151 AND y > 243 AND y < 268) OR
				(x > 127 AND x < 151 AND y > 236 AND y < 244) OR
				(x > 155 AND x < 172 AND y > 212 AND y < 276) OR
				(x > 162 AND x < 195 AND y > 205 AND y < 213) OR
				(x > 186 AND x < 203 AND y > 212 AND y < 276) OR
				(x > 171 AND x < 187 AND y > 243 AND y < 254) OR--A
				(x > 265 AND x < 282 AND y > 205 AND y < 276) OR-- E corregido
				(x > 281 AND x < 313 AND y > 205 AND y < 214) OR
				(x > 281 AND x < 305 AND y > 236 AND y < 245) OR
				(x > 281 AND x < 313 AND y > 267 AND y < 276) OR
				(x > 438 AND x < 455 AND y > 205 AND y < 276) OR
				(x > 454 AND x < 486 AND y > 205 AND y < 214) OR
				(x > 454 AND x < 478 AND y > 236 AND y < 245) OR
				(x > 454 AND x < 486 AND y > 267 AND y < 276) OR
				(x > 444 AND x < 376 AND y > 205 AND y < 214) OR
				(x > 336 AND x < 353 AND y > 213 AND y < 268) OR
				(x > 344 AND x < 376 AND y > 264 AND y < 276) OR--o
				(x > 367 AND x < 384 AND y > 213 AND y < 268) OR
				(x > 344 AND x < 376 AND y > 206 AND y < 215) OR
				(x > 387 AND x < 404 AND y > 205 AND y < 245) OR
				(x > 395 AND x < 428 AND y > 244 AND y < 260) OR
				(x > 403 AND x < 419 AND y > 259 AND y < 276) OR
				(x > 418 AND x < 435 AND y > 205 AND y < 245) OR
				(x > 490 AND x < 506 AND y > 205 AND y < 276) OR--r
				(x > 505 AND x < 530 AND y > 205 AND y < 214) OR--rb
				(x > 521 AND x < 537 AND y > 213 AND y < 237) OR--rb
				(x > 505 AND x < 530 AND y > 236 AND y < 245) OR
				(x > 521 AND x < 537 AND y > 244 AND y < 276) OR
				(x > 206 AND x < 215 AND y > 205 AND y < 276) OR--mb
				(x > 214 AND x < 223 AND y > 212 AND y < 276) OR--mb
				(x > 222 AND x < 231 AND y > 220 AND y < 238) OR--mb
				(x > 230 AND x < 239 AND y > 227 AND y < 245) OR--mb
				(x > 238 AND x < 246 AND y > 220 AND y < 238) OR
				(x > 245 AND x < 254 AND y > 212 AND y < 276) OR
				(x > 253 AND x < 262 AND y > 205 AND y < 276) --mb
				THEN
				R <= "1111"; -- Rojo
				G <= "1111"; -- Verde
				B <= "1111"; -- Azul
			ELSE
				R <= "0000"; -- Rojo
				G <= "0000"; -- Verde
				B <= "0000"; -- Azul
			END IF;

		ELSIF DT = "11" AND opcion = "11111111" THEN -- start game
			IF (x > 157 AND x < 183 AND y > 175 AND y < 190) OR
				(x > 124 AND x < 172 AND y > 162 AND y < 176) OR
				(x > 113 AND x < 140 AND y > 175 AND y < 199) OR
				(x > 125 AND x < 183 AND y > 198 AND y < 210) OR
				(x > 169 AND x < 194 AND y > 209 AND y < 232) OR--sb
				(x > 125 AND x < 183 AND y > 231 AND y < 245) OR
				(x > 113 AND x < 138 AND y > 217 AND y < 232) OR
				(x > 193 AND x < 264 AND y > 162 AND y < 178) OR -- tb
				(x > 215 AND x < 241 AND y > 177 AND y < 245) OR--t
				(x > 289 AND x < 327 AND y > 162 AND y < 175) OR--a
				(x > 278 AND x < 305 AND y > 174 AND y < 188) OR
				(x > 269 AND x < 294 AND y > 187 AND y < 245) OR--a
				(x > 293 AND x < 325 AND y > 207 AND y < 222) OR
				(x > 313 AND x < 339 AND y > 174 AND y < 188) OR
				(x > 324 AND x < 348 AND y > 187 AND y < 245) OR
				(x > 352 AND x < 380 AND y > 162 AND y < 245) OR
				(x > 379 AND x < 424 AND y > 162 AND y < 176) OR--r
				(x > 408 AND x < 429 AND y > 175 AND y < 196) OR--r
				(x > 397 AND x < 425 AND y > 195 AND y < 210) OR
				(x > 379 AND x < 412 AND y > 209 AND y < 220) OR--r
				(x > 387 AND x < 425 AND y > 219 AND y < 230) OR
				(x > 397 AND x < 435 AND y > 229 AND y < 244) OR--r
				(x > 450 AND x < 520 AND y > 162 AND y < 178) OR
				(x > 472 AND x < 499 AND y > 177 AND y < 245) OR
				(x > 169 AND x < 230 AND y > 260 AND y < 277) OR
				(x > 158 AND x < 186 AND y > 276 AND y < 287) OR
				(x > 147 AND x < 175 AND y > 286 AND y < 321) OR
				(x > 158 AND x < 184 AND y > 320 AND y < 332) OR
				(x > 169 AND x < 230 AND y > 331 AND y < 343) OR
				(x > 203 AND x < 230 AND y > 293 AND y < 332) OR
				(x > 191 AND x < 204 AND y > 293 AND y < 309) OR
				(x > 183 AND x < 203 AND y > 326 AND y < 332) OR
				(x > 255 AND x < 293 AND y > 260 AND y < 274) OR
				(x > 244 AND x < 272 AND y > 273 AND y < 288) OR
				(x > 233 AND x < 260 AND y > 287 AND y < 342) OR
				(x > 259 AND x < 289 AND y > 304 AND y < 321) OR
				(x > 288 AND x < 316 AND y > 287 AND y < 342) OR
				(x > 278 AND x < 305 AND y > 273 AND y < 288) OR
				(x > 404 AND x < 432 AND y > 260 AND y < 343) OR
				(x > 431 AND x < 487 AND y > 260 AND y < 277) OR
				(x > 431 AND x < 476 AND y > 294 AND y < 310) OR
				(x > 431 AND x < 487 AND y > 327 AND y < 343) OR
				(x > 319 AND x < 345 AND y > 260 AND y < 343) OR
				(x > 374 AND x < 401 AND y > 260 AND y < 343) OR
				(x > 344 AND x < 357 AND y > 272 AND y < 310) OR
				(x > 356 AND x < 365 AND y > 283 AND y < 320) OR
				(x > 364 AND x < 376 AND y > 272 AND y < 310) OR
				(x > 440 AND x < 451 AND y > 162 AND y < 173) OR
				(x > 519 AND x < 530 AND y > 162 AND y < 173)
				THEN
				R <= "1111"; -- Rojo
				G <= "1111"; -- Verde
				B <= "1111"; -- Azul
			ELSE
				R <= "0000"; -- Rojo
				G <= "0000"; -- Verde
				B <= "0000"; -- Azul
			END IF;

		ELSE
			R <= "0000"; -- Rojo
			G <= "0000"; -- Verde
			B <= "0000"; -- Azul
		END IF;

	END PROCESS;

END Behav;
