LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Multiplier IS
    GENERIC(N: INTEGER := 5);
    PORT (
          A           : IN  STD_LOGIC_VECTOR(N-1             DOWNTO 0);
          B           : IN  STD_LOGIC_VECTOR(N-1             DOWNTO 0);
          Res         : OUT STD_LOGIC_VECTOR(2*(N-1)-1       DOWNTO 0)
    );
END ENTITY Multiplier;

ARCHITECTURE MultiplierArch OF Multiplier IS

     SIGNAL part_Prod : STD_LOGIC_VECTOR((N * N) - 1         DOWNTO 0);
     SIGNAL part_Sum  : STD_LOGIC_VECTOR((N * (N+1)) - 1     DOWNTO 0);

BEGIN


     part: FOR i IN 0 TO N-1 GENERATE

          part2: FOR j IN 0 TO N-1 GENERATE

               part_Prod(i*N + j) <= A(i) AND B(j);

        END GENERATE;

    END GENERATE;

     part_Sum(N DOWNTO 0) <= part_Prod(N-1) & part_Prod(N-1  DOWNTO 0);

     Ripples: FOR i IN 0 TO N-2 GENERATE

          Adder: ENTITY WORK.RippleCAdder
                 GENERIC MAP 
                 (
                    N => N
                 )
                 PORT MAP 
                 (
                    Mode => '0',
                    A => part_Sum ( (N)   + (N + 1) * (i)    DOWNTO ( (N + 1)*(i) ) + 1 ),
                    B => part_Prod( (N-1) +  N *(i+1)        DOWNTO  N*(i+1)            ),
                    S => part_Sum ( (N)   + (N + 1)*(i+1)    DOWNTO (N + 1) * (i+1)     ) 
                 );
          Res(i) <= part_Sum((N + 1)*i);

     END GENERATE;
     Res(2*(N-1)-1 DOWNTO N-1) <= part_Sum(N-2 + (N+1)*(N-1) DOWNTO (N+1)*(N-1));


END MultiplierArch;

