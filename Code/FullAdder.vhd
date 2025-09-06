--                                                                                      --
--                                 Thomas Leal Puerta                                   --
--                                                                                      --
--  Project: Lab-01_5.1                                                                 --
--  Date:  08/07/2024                                                                   --
--                                                                                      --
------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY FullAdder IS
    
    PORT   (Cin : IN  STD_LOGIC;
            A : IN  STD_LOGIC;
            B : IN  STD_LOGIC;
            Cout  : OUT STD_LOGIC;
            S  : OUT STD_LOGIC
           );
    
END ENTITY FullAdder;


ARCHITECTURE FullAdderArch OF FullAdder IS

BEGIN

    S <= (A XOR B) XOR Cin;
    Cout <= (A AND B) OR (Cin AND (A XOR B));


END FullAdderArch;