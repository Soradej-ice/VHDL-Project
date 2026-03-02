library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity analysis_unit is
    Port (
        vote_count_array   : in  std_logic_vector(31 downto 0);
        remaining_votes    : in  std_logic_vector(7 downto 0);

        tie_flag           : out std_logic;
        early_winner_flag  : out std_logic
    );
end analysis_unit;

architecture behavioral of analysis_unit is
begin

    tie_flag          <= '0';
    early_winner_flag <= '0';

end behavioral;
