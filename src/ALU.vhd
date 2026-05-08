----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
    signal w_result : unsigned(8 downto 0);
    signal w_A : unsigned(8 downto 0);
begin
    w_A <= unsigned('0' & i_A);

    w_result <= w_A + unsigned('0' & i_B) when i_op = "000" else
                w_A + unsigned('0' & not i_B) + 1 when i_op = "001" else
                unsigned('0' & (i_A and i_B)) when i_op = "010" else
                unsigned('0' & (i_A or i_B)) when i_op = "011" else
                (others => '0');

    o_result <= std_logic_vector(w_result(7 downto 0));
    
    o_flags(3) <= w_result(7);
    o_flags(2) <= '1' when w_result(7 downto 0) = "00000000" else '0';
    o_flags(1) <= w_result(8) when (i_op = "000" or i_op = "001") else '0';
    o_flags(0) <= (not i_A(7) and not i_B(7) and w_result(7)) or (i_A(7) and i_B(7) and not w_result(7)) when i_op = "000" else
                  (not i_A(7) and i_B(7) and w_result(7)) or (i_A(7) and not i_B(7) and not w_result(7)) when i_op = "001" else
                  '0';
end Behavioral;