LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RippleCAdder IS
    
    GENERIC(N: INTEGER := 4);

    PORT   (
            Mode : IN  STD_LOGIC;
            A : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
            B : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR (N downto 0)
           );

END ENTITY RippleCAdder;


ARCHITECTURE RippleCAdderArch OF RippleCAdder IS

    SIGNAL C : STD_LOGIC_VECTOR (N+1 DOWNTO 0);
    SIGNAL Sum : STD_LOGIC_VECTOR (N DOWNTO 0);
    SIGNAL temp_A : STD_LOGIC_VECTOR (N DOWNTO 0);
    SIGNAL temp_B : STD_LOGIC_VECTOR (N DOWNTO 0);
    SIGNAL ComplB : STD_LOGIC_VECTOR (N DOWNTO 0);

BEGIN

    C(0) <= Mode;
    temp_A <= A(N-1) & A;
    temp_B <= B(N-1) & B;
    Complement: FOR i IN 0 TO N GENERATE
        ComplB(i) <= temp_B(i) XOR Mode;
    END GENERATE;

    Adders: FOR i IN 0 TO N GENERATE
        Adder: ENTITY WORK.FullAdder
        PORT MAP   (    A => temp_A(i),
                        B => ComplB(i),
                        Cin => C(i),
                        S => Sum(i),
                        Cout => C(i+1)
                   );

    END GENERATE;

    S <= Sum;

END RippleCAdderArch;