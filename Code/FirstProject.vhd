LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FirstProject IS
    GENERIC(N: INTEGER := 4);
    PORT (
        Selop  : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        A      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        B      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        ASseg  : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        BSseg  : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        Q1Sseg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        Q2Sseg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END ENTITY FirstProject;

ARCHITECTURE FirstProjectArch OF FirstProject IS
    SIGNAL SignA  : STD_LOGIC_VECTOR(N DOWNTO 0);
    SIGNAL SignB  : STD_LOGIC_VECTOR(N DOWNTO 0);
    SIGNAL Reslt  : STD_LOGIC_VECTOR(2*N-1 DOWNTO 0);
    SIGNAL nRslt  : STD_LOGIC_VECTOR(2*N-1 DOWNTO 0);
    SIGNAL Rabs   : STD_LOGIC_VECTOR(2*N-1 DOWNTO 0);
    SIGNAL Q1     : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Q2     : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL outQ1  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL outQ2  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Q1SNum : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL Q1Res  : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL A7, B7 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL Q2Num  : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL ERR    : STD_LOGIC;
    CONSTANT E7   : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000110";
BEGIN
    SignA <= '0' & A;
    SignB <= '0' & B;

    Au : ENTITY WORK.AritmeticUnit
        GENERIC MAP (N => N+1)
        PORT MAP (SelOp => Selop, A => SignA, B => SignB, Q => Reslt);

    TwoScomp : ENTITY WORK.twocomp
        GENERIC MAP (N => 2*N)
        PORT MAP (X => Reslt, Y => nRslt);

    Rabs <= nRslt WHEN Reslt(2*N-1) = '1' ELSE Reslt;

    Bin2BCD : ENTITY WORK.binToBCD
        PORT MAP (N => Rabs, T => Q1, U => Q2);

    outQ1 <= Q1;
    outQ2 <= Q2;

    Q1_7seg : ENTITY WORK.bin_to_7seg
        PORT MAP (bin_in => outQ1, seg_out => Q1SNum);

    Q2_7seg : ENTITY WORK.bin_to_7seg
        PORT MAP (bin_in => outQ2, seg_out => Q2Num);

    A_7seg : ENTITY WORK.bin_to_7seg
        PORT MAP (bin_in => A, seg_out => A7);

    B_7seg : ENTITY WORK.bin_to_7seg
        PORT MAP (bin_in => B, seg_out => B7);

    ERR <= '1' WHEN (((A(N-1) AND (A(N-2) OR A(N-3))) = '1') OR
                     ((B(N-1) AND (B(N-2) OR B(N-3))) = '1')) ELSE '0';

    Q1Res <= "0111111" WHEN Reslt(2*N-1) = '1' ELSE Q1SNum;

    ASseg  <= E7 WHEN ERR = '1' ELSE A7;
    BSseg  <= E7 WHEN ERR = '1' ELSE B7;
    Q1Sseg <= E7 WHEN ERR = '1' ELSE Q1Res;
    Q2Sseg <= E7 WHEN ERR = '1' ELSE Q2Num;

END ARCHITECTURE FirstProjectArch;

