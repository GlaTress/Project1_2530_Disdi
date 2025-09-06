LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY binToBCD IS
  PORT (
    N : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
    T : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    U : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE behavioral OF binToBCD IS
  SIGNAL hBits  : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL lBits  : STD_LOGIC_VECTOR(3 DOWNTO 0);

  SIGNAL baseT  : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL adjVal : STD_LOGIC_VECTOR(4 DOWNTO 0);

  SIGNAL extLB  : STD_LOGIC_VECTOR(4 DOWNTO 0);

  SIGNAL adj20  : STD_LOGIC;
  SIGNAL adj10  : STD_LOGIC;

  SIGNAL tAdj   : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL uAdj   : STD_LOGIC_VECTOR(4 DOWNTO 0);

  SIGNAL finU   : STD_LOGIC_VECTOR(4 DOWNTO 0);

  SIGNAL intSum_w : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL finT_w   : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL res_w    : STD_LOGIC_VECTOR(6 DOWNTO 0);

  SIGNAL sum6   : STD_LOGIC_VECTOR(5 DOWNTO 0);
  SIGNAL adj6   : STD_LOGIC_VECTOR(5 DOWNTO 0);
BEGIN
  hBits <= N(6 DOWNTO 4);
  lBits <= N(3 DOWNTO 0);

  WITH hBits SELECT
     baseT <=  "0000" WHEN "000",
               "0001" WHEN "001",
               "0011" WHEN "010",
               "0100" WHEN "011",
               "0110" WHEN "100",
               "0111" WHEN "101",
               "0000" WHEN OTHERS;

  WITH hBits SELECT
     adjVal <= "00000" WHEN "000",
               "00110" WHEN "001",
               "00010" WHEN "010",
               "01000" WHEN "011",
               "00100" WHEN "100",
               "01010" WHEN "101",
               "00000" WHEN OTHERS;

  extLB <= '0' & lBits;

  adder1: ENTITY work.RippleCAdder
    GENERIC MAP (N => 5)
    PORT MAP (
      A    => adjVal,
      B    => extLB,
      Mode => '0',
      S    => intSum_w 
    );

  adj20 <= intSum_w(4) AND (intSum_w(3) OR intSum_w(2));
  adj10 <= ((NOT intSum_w(4)) AND intSum_w(3) AND (intSum_w(2) OR intSum_w(1)))
        OR (intSum_w(4) AND (NOT (intSum_w(3) OR intSum_w(2))));

  tAdj <= "0010" WHEN adj20 = '1' ELSE
          "0001" WHEN adj10 = '1' ELSE
          "0000";

  adder2: ENTITY work.RippleCAdder
    GENERIC MAP (N => 4)
    PORT MAP (
      A    => baseT,
      B    => tAdj,
      Mode => '0',
      S    => finT_w
    );

  uAdj <= "10100" WHEN adj20 = '1' ELSE
          "01010" WHEN adj10 = '1' ELSE
          "00000";

  sum6 <= intSum_w;  
  adj6 <= '0' & uAdj;

  adder3: ENTITY work.RippleCAdder
    GENERIC MAP (N => 6)
    PORT MAP (
      A    => sum6,
      B    => adj6,
      Mode => '1',
      S    => res_w
    );

  T <= finT_w(3 DOWNTO 0);
  finU <= res_w(4 DOWNTO 0);
  U <= finU(3 DOWNTO 0);
END ARCHITECTURE;
