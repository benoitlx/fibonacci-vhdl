library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity binary2bcd is
  port (
         binary_in : in  STD_LOGIC_VECTOR(19 downto 0);
         ones      : out STD_LOGIC_VECTOR(3 downto 0);
         tens      : out STD_LOGIC_VECTOR(3 downto 0);
         hundreds  : out STD_LOGIC_VECTOR(3 downto 0);
         thousands : out STD_LOGIC_VECTOR(3 downto 0);
         ten_thousands : out STD_LOGIC_VECTOR(3 downto 0);
         hundred_thousands : out STD_LOGIC_VECTOR(3 downto 0)
       );
end binary2bcd;

architecture Behavioral of binary2bcd is
begin

  bcd_proc: process(binary_in)
    variable shift_reg : unsigned(43 downto 0) := (others => '0');
  begin
      -- Initialize shift register with input binary number and leading zeros
    shift_reg := (others => '0');
    shift_reg(19 downto 0) := unsigned(binary_in);

      -- Perform double-dabble algorithm
    for i in 0 to 19 loop

        -- Adjust BCD digits if necessary
      if shift_reg(43 downto 40) >= 5 then
        shift_reg(43 downto 40) := shift_reg(43 downto 40) + 3;
      end if;

      if shift_reg(39 downto 36) >= 5 then
        shift_reg(39 downto 36) := shift_reg(39 downto 36) + 3;
      end if;

      if shift_reg(35 downto 32) >= 5 then
        shift_reg(35 downto 32) := shift_reg(35 downto 32) + 3;
      end if;

      if shift_reg(31 downto 28) >= 5 then
        shift_reg(31 downto 28) := shift_reg(31 downto 28) + 3;
      end if;

      if shift_reg(27 downto 24) >= 5 then
        shift_reg(27 downto 24) := shift_reg(27 downto 24) + 3;
      end if;

      if shift_reg(23 downto 20) >= 5 then
        shift_reg(23 downto 20) := shift_reg(23 downto 20) + 3;
      end if;

      shift_reg(43 downto 1) := shift_reg(42 downto 0);
      shift_reg(0) := '0';

    end loop;

      -- Assign BCD digits to output
    hundred_thousands <= STD_LOGIC_VECTOR(shift_reg(43 downto 40));
    ten_thousands     <= STD_LOGIC_VECTOR(shift_reg(39 downto 36));
    thousands         <= STD_LOGIC_VECTOR(shift_reg(35 downto 32));
    hundreds          <= STD_LOGIC_VECTOR(shift_reg(31 downto 28));
    tens              <= STD_LOGIC_VECTOR(shift_reg(27 downto 24));
    ones              <= STD_LOGIC_VECTOR(shift_reg(23 downto 20));
  end process;

end Behavioral;
