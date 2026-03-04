entity vote_memory is
    Port (
        clk     : in std_logic;
        rst     : in std_logic;

        voter_id    : in unsigned(9 downto 0);
        vote_valid  : in std_logic;

        voted_flag  : out std_logic
    );
end vote_memory;

architecture behavioral of vote_memory is
begin
    -- เก็บ ID และป้องกันโหวตซ้ำ
end behavioral;
