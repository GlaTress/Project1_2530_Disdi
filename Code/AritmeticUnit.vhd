----------------------------------------------------------
--        PONTIFICIA UNIVERSIDAD JAVERIANA              --
--                Disenno Digital                       --
--                                                      --
----------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------
-- Comentarios:
-- 
-- 
----------------------------------------------------------
ENTITY AritmeticUnit IS
    GENERIC(N: INTEGER := 5);

     PORT 
     (
          SelOp  : IN   STD_LOGIC_VECTOR(1          DOWNTO 0);
          A      : IN   STD_LOGIC_VECTOR(N-1        DOWNTO 0);
          B      : IN   STD_LOGIC_VECTOR(N-1        DOWNTO 0);
          Q      : OUT  STD_LOGIC_VECTOR(2*(N-1)-1  DOWNTO 0)
     );

END ENTITY AritmeticUnit;

ARCHITECTURE AritmeticUnitArch OF AritmeticUnit IS

    SIGNAL sum   :      STD_LOGIC_VECTOR(N          DOWNTO 0);
    SIGNAL eSum  :      STD_LOGIC_VECTOR(2*(N-1)-1  DOWNTO 0);
    SIGNAL mode  :      STD_LOGIC                            ;
    SIGNAL mult  :      STD_LOGIC_VECTOR(2*(N-1)-1  DOWNTO 0);

BEGIN

     mode <= NOT selop(0);

     Add_Sub : ENTITY WORK.RippleCAdder
          GENERIC MAP 
          (
               N => N
          )
          PORT MAP 
          (
               A    => A    ,
               B    => B    ,
               Mode => mode ,
               S    => Sum   
          );

     ESum(2*(N-1)-1 downto N+1) <= (others => Sum(N));
     ESum(N downto 0)           <= Sum;


     Multiplier : ENTITY WORK.Multiplier
          GENERIC MAP
          (
               N => N
          )
          PORT MAP
          (
               A   => A     ,
               B   => B     ,
               Res => mult   
          );


     Q    <= mult WHEN Selop(1) = '0' ELSE
             ESum;

----------------------------------------------------------
--                                                      --
-- Summon This Block:                                   --
--                                                      --
----------------------------------------------------------
--BlockN: ENTITY WORK.AritmeticUnit                     --
--GENERIC MAP(N => #)                                   --
--PORT MAP                                              --
--  (SelOp => SLV,                                      --
--   A     => SLV,                                      --
--   B     => SLV,                                      --
--   Q     => SLV                                       --
--  );                                                  --
----------------------------------------------------------

END AritmeticUnitArch;