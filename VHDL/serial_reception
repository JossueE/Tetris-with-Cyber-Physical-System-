LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY serial_comunication IS
  PORT (
    new_clk : IN STD_LOGIC;
    llegada : IN STD_LOGIC
    display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  );
END serial_comunication;

ARCHITECTURE behav OF serial_comunication IS

  TYPE estados_type IS (reposo, comienzo, s1, s2, s3, s4, s5, s6, s7, s8, s9);
  SIGNAL estado : estados_type;

BEGIN

  U0 : contador_JKG GENERIC MAP(2605) PORT MAP(clk, new_clk);

  PROCESS (new_clk, button)
  BEGIN
    IF rising_edge(new_clk) THEN
      CASE estado IS
        WHEN reposo =>
          IF button = '0' THEN
            estado <= comienzo;
          END IF;
        WHEN comienzo =>
          estado <= s1;
        WHEN s1 =>
          estado <= s2;
        WHEN s2 =>
          estado <= s3;
        WHEN s3 =>
          estado <= s4;
        WHEN s4 =>
          estado <= s5;
        WHEN s5 =>
          estado <= s6;
        WHEN s6 =>
          estado <= s7;
        WHEN s7 =>
          estado <= s8;
        WHEN s8 =>
          estado <= s9;
        WHEN s9 =>
          IF button = '0' THEN
            estado <= estado;
          ELSE
            estado <= reposo;
          END IF;
      END CASE;
    END IF;
  END PROCESS;

  llegada <= '1' WHEN estado = reposo ELSE
    '0' WHEN estado = comienzo ELSE
    switches(0) WHEN estado = s1 ELSE
    switches(1) WHEN estado = s2 ELSE
    switches(2) WHEN estado = s3 ELSE
    switches(3) WHEN estado = s4 ELSE
    switches(4) WHEN estado = s5 ELSE
    switches(5) WHEN estado = s6 ELSE
    switches(6) WHEN estado = s7 ELSE
    switches(7) WHEN estado = s8 ELSE
    '1' WHEN estado = s9;
END behav;
