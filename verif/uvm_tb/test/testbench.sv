// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
import uvm_pkg::*;
	`include "uvm_macros.svh"
	`include "interface.sv"
  	`include "pixel_config.sv"
	`include "env_config.sv"
	
	`include "pixel_xtn.sv"
	`include "pixel_sequencer.sv"
	`include "pixel_driver.sv"
	`include "pixel_monitor.sv"
	`include "pixel_agent.sv"
	`include "pixel_sequence.sv"

	`include "scoreboard.sv"
	`include "env.sv"
	`include "test.sv"
module top;
  	
  	
	bit clk;
	
	always #1 clk = ~clk;
	
	pixel_if if0(clk);
	
	//DUT_instantation
	
	initial begin
      `ifdef VCS
      $dumpfile("wave.vcd");
      $dumpvars(0, top);
      `endif
      
      uvm_config_db#(virtual pixel_if)::set(null,"*","vif",if0);
	  uvm_top.enable_print_topology =1;
	  run_test("test");
	end
endmodule