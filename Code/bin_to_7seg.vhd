LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY bin_to_7seg IS
    PORT (
        bin_in : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        seg_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END bin_to_7seg;

ARCHITECTURE Behavioral OF bin_to_7seg IS
BEGIN
    WITH bin_in SELECT
        seg_out <= "1000000" WHEN "0000",--'0'
                   "1111001" WHEN "0001",--'1'
                   "0100100" WHEN "0010",--'2'
                   "0110000" WHEN "0011",--'3'
                   "0011001" WHEN "0100",--'4'
                   "0010010" WHEN "0101",--'5'
                   "0000010" WHEN "0110",--'6'
                   "1111000" WHEN "0111",--'7'
                   "0000000" WHEN "1000",--'8'
                   "0010000" WHEN "1001",--'9'
                   "0000110" WHEN  OTHERS;
END Behavioral;