library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_divider_tb is
end clock_divider_tb;

architecture Behavioral of clock_divider_tb is
  -- Component declaration for the unit under test (UUT)
  component clock_divider 
    generic (
      N : integer := 10
    );
    port (
      clk : in STD_LOGIC;
      raz : in STD_LOGIC;
      cout : out STD_LOGIC
    );
  end component;

  -- Testbench signals
  signal clk : STD_LOGIC := '0';
  signal raz : STD_LOGIC := '0';
  signal cout : STD_LOGIC;

  constant clk_period : time := 10 ns;

begin
  -- Instantiate the Unit Under Test (UUT)
  uut: clock_divider 
    generic map (
      N => 10
    )
    port map (
      clk => clk,
      raz => raz,
      cout => cout
    );

  -- Clock generation
  clk_process : process
  begin
    while true loop
      clk <= '0';
      wait for clk_period / 2;
      clk <= '1';
      wait for clk_period / 2;
    end loop;
  end process;

  -- Stimulus process
  stim_proc: process
  begin
    -- Initialize reset
    raz <= '1';
    wait for 20 ns;
    raz <= '0';
    
    -- Wait and observe output
    wait for 200 ns;

    -- Apply reset
    raz <= '1';
    wait for 20 ns;
    raz <= '0';

    -- Wait and observe output
    wait for 200 ns;

    -- Finish simulation
    wait;
  end process;

end Behavioral;
