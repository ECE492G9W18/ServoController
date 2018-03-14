-- new_component.vhd

-- This file was auto-generated as a prototype implementation of a module
-- created in component editor.  It ties off all outputs to ground and
-- ignores all inputs.  It needs to be edited to make it do something
-- useful.
-- 
-- This file will not be automatically regenerated.  You should check it in
-- to your version control system if you want to keep it.

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
begin

	-- TODO: Auto-generated HDL template

	conduit_end_servo <= '0';

	avs_s0_readdata <= "00000000000000000000000000000000";

end architecture rtl; -- of new_component
