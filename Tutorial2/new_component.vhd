-- new_component.vhd

-- This file was auto-generated as a prototype implementation of a module
-- created in component editor.  It ties off all outputs to ground and
-- ignores all inputs.  It needs to be edited to make it do something
-- useful.
-- 
-- This file will not be automatically regenerated.  You should check it in
-- to your version control system if you want to keep it.

-- Adapted from previous application notes by:
-- Ryan Corpuz
-- rcorpuz@ualberta.ca
-- This file is a servo motor PWM, which is used to send signals to servos
-- for servo control. This particular driver is designed around the Hitec Servos
-- and are optimized for these servos.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity new_component is
	port (
		clk               : in  std_logic                     := '0';             --       clock.clk
		reset_n           : in  std_logic                     := '0';             --       reset.reset_n
		conduit_end_servo : out std_logic;                                        -- conduit_end.export
		avs_s0_read_n     : in  std_logic                     := '0';             --          s0.read_n
		avs_s0_readdata   : out std_logic_vector(31 downto 0);                    --            .readdata
		avs_s0_write_n    : in  std_logic                     := '0';             --            .write_n
		avs_s0_writedata  : in  std_logic_vector(31 downto 0) := (others => '0')  --            .writedata
	);
end entity new_component;

architecture rtl of new_component is

	type state is (low, high);	
	signal current_state:state := high;
	signal direction:std_logic_vector (31 downto 0);
begin

latch_direction: process(clk,avs_s0_write_n) is
	begin
		if falling_edge(avs_s0_write_n) then
			direction <= avs_s0_writedata;
		end if;
	end process;
	
write_data: process(clk,avs_s0_read_n) is
	begin
		if rising_edge(avs_s0_read_n) then
			avs_s0_readdata <= direction;
		end if;
	end process;

pwm: process( reset_n, clk ) is
		-- 50 MHz with a 20 ms refresh rate means period is 1000000 clk cycles between each puls
		variable period_count: integer := 1000000; -- How man clocks to count from falling edge of first pulse to rising edge of second pulse
		variable pulse_count: integer:= 75000; -- This is 1.5ms pulse for neurtral position
		
	begin
		if ( reset_n = '0' ) then
				period_count := 1000000;
				pulse_count := 75000;
		elsif rising_edge(clk) then
			if ( current_state = high ) then
				if ( pulse_count > 0 ) then
					pulse_count := pulse_count - 1;
					conduit_end_servo <= '1';
				elsif ( pulse_count = 0 ) then
					current_state <= low;
					pulse_count := to_integer(unsigned(direction));
					if (pulse_count = 0 ) then
						pulse_count := 75000;
					end if;
				end if;
			elsif ( current_state = low ) then
				if ( period_count > 0 ) then
					period_count := period_count - 1;
					conduit_end_servo <= '0';
				elsif ( period_count = 0 ) then
					period_count := 1000000;
					current_state <= high;
				end if;
			end if;
		end if;
	end process;

end architecture rtl; -- of new_component
