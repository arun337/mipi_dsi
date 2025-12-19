package pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "pixel_config.sv"
	`include "env_config.sv"
	
	`include "pixel_xtn.sv"
	`include "pixel_sequencer.sv"
	`include "pixel_driver.sv"
	`include "pixel_monitor.sv"
`	`include "pixel_agent.sv"

	`include "scoreboard.sv"
	`include "env.sv"
	`include "test.sv"
	
endpackage