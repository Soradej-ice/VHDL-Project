library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk   : in  std_logic;

        sw    : in  std_logic_vector(15 downto 0);
        btn   : in  std_logic_vector(4 downto 0);

        led   : out std_logic_vector(10 downto 0);
        seg   : out std_logic_vector(6 downto 0);
        an    : out std_logic_vector(3 downto 0)
    );
end top;

architecture structural of top is

    ----------------------------------------------------------------
    -- Internal Signals
    ----------------------------------------------------------------

    -- Input Controller → FSM
    signal mode_select        : std_logic;
    signal voter_id           : std_logic_vector(7 downto 0);
    signal admin_pass         : std_logic_vector(3 downto 0);
    signal candidate_select   : std_logic_vector(1 downto 0);

    signal btn_confirm        : std_logic;
    signal btn_left           : std_logic;
    signal btn_right          : std_logic;
    signal btn_up             : std_logic;
    signal btn_down           : std_logic;

    -- FSM Control Signals
    signal current_state      : std_logic_vector(3 downto 0);
    signal memory_write_en    : std_logic;
    signal analysis_trigger   : std_logic;
    signal timeout_enable     : std_logic;
    signal reset_system       : std_logic;

    -- Memory / Analysis Feedback
    signal id_valid           : std_logic;
    signal already_voted      : std_logic;
    signal vote_count_array   : std_logic_vector(31 downto 0);
    signal remaining_votes    : std_logic_vector(7 downto 0);
    signal tie_flag           : std_logic;
    signal early_winner_flag  : std_logic;

    -- Timeout / Security
    signal timeout_flag       : std_logic;

begin

    ----------------------------------------------------------------
    -- INPUT CONTROLLER
    ----------------------------------------------------------------
    u_input : entity work.input_controller
    port map(
        clk              => clk,
        sw               => sw,
        btn              => btn,

        mode_select      => mode_select,
        voter_id         => voter_id,
        admin_pass       => admin_pass,
        candidate_select => candidate_select,

        btn_confirm      => btn_confirm,
        btn_left         => btn_left,
        btn_right        => btn_right,
        btn_up           => btn_up,
        btn_down         => btn_down
    );

    ----------------------------------------------------------------
    -- MAIN FSM
    ----------------------------------------------------------------
    u_fsm : entity work.main_fsm
    port map(
        clk               => clk,
        mode_select       => mode_select,
        btn_confirm       => btn_confirm,
        btn_left          => btn_left,
        btn_right         => btn_right,
        btn_up            => btn_up,
        btn_down          => btn_down,

        id_valid          => id_valid,
        already_voted     => already_voted,
        timeout_flag      => timeout_flag,
        tie_flag          => tie_flag,
        early_winner_flag => early_winner_flag,

        current_state     => current_state,
        memory_write_en   => memory_write_en,
        analysis_trigger  => analysis_trigger,
        timeout_enable    => timeout_enable,
        reset_system      => reset_system
    );

    ----------------------------------------------------------------
    -- MEMORY UNIT
    ----------------------------------------------------------------
    u_memory : entity work.memory_unit
    port map(
        clk               => clk,
        reset_system      => reset_system,
        voter_id          => voter_id,
        candidate_select  => candidate_select,
        write_enable      => memory_write_en,

        id_valid          => id_valid,
        already_voted     => already_voted,
        vote_count_array  => vote_count_array,
        remaining_votes   => remaining_votes
    );

    ----------------------------------------------------------------
    -- ANALYSIS UNIT
    ----------------------------------------------------------------
    u_analysis : entity work.analysis_unit
    port map(
        vote_count_array   => vote_count_array,
        remaining_votes    => remaining_votes,

        tie_flag           => tie_flag,
        early_winner_flag  => early_winner_flag
    );

    ----------------------------------------------------------------
    -- TIMEOUT UNIT
    ----------------------------------------------------------------
    u_timeout : entity work.timeout_unit
    port map(
        clk          => clk,
        enable       => timeout_enable,
        timeout_flag => timeout_flag
    );

    ----------------------------------------------------------------
    -- DISPLAY CONTROLLER
    ----------------------------------------------------------------
    u_display : entity work.display_controller
    port map(
        clk               => clk,
        current_state     => current_state,
        vote_count_array  => vote_count_array,
        tie_flag          => tie_flag,
        early_winner_flag => early_winner_flag,

        led               => led,
        seg               => seg,
        an                => an
    );

end structural;
