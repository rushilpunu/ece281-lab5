----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller_fsm is
    Port ( i_reset : in STD_LOGIC;
           i_adv : in STD_LOGIC;
           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
end controller_fsm;

architecture FSM of controller_fsm is
    type state_type is (s_clear, s_store_a, s_store_b, s_result);
    signal current_state, next_state : state_type;
begin
    process(i_adv, i_reset)
    begin
        if i_reset = '1' then
            current_state <= s_clear;
        elsif rising_edge(i_adv) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state)
    begin
        case current_state is
            when s_clear =>
                next_state <= s_store_a;
                o_cycle <= "0001";
            when s_store_a =>
                next_state <= s_store_b;
                o_cycle <= "0010";
            when s_store_b =>
                next_state <= s_result;
                o_cycle <= "0100";
            when s_result =>
                next_state <= s_clear;
                o_cycle <= "1000";
        end case;
    end process;
end FSM;