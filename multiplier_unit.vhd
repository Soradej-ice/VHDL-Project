library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier_unit is
    Port (
        clk     : in  std_logic;
        rst     : in  std_logic;

        start   : in  std_logic;

        a       : in  unsigned(15 downto 0);
        b       : in  unsigned(15 downto 0);

        p       : out unsigned(31 downto 0);

        done    : out std_logic
    );
end multiplier_unit;

architecture skeleton of multiplier_unit is

    -- internal signals
    signal product_reg : unsigned(31 downto 0);
    signal busy        : std_logic;

begin

    -- main process (เติม logic ภายหลัง)
    process(clk, rst)
    begin
        if rst = '1' then
            product_reg <= (others => '0');
            busy <= '0';
            done <= '0';

        elsif rising_edge(clk) then

            -- start multiplication
            if start = '1' then
                busy <= '1';
                done <= '0';
            end if;

            -- TODO:
            -- ใส่ algorithm การคูณที่เลือกในภายหลัง

            -- เมื่อคำนวณเสร็จ
            -- busy <= '0';
            -- done <= '1';

        end if;
    end process;

    p <= product_reg;

end skeleton;
