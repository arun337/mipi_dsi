`include "cs_mipi_config.sv"
class ppi_env extends uvm_env;
  `uvm_component_utils(ppi_env)

   ppi_agent agent;
   cs_mipi_config mipi_cfg;

	function new(string name="ppi_env", uvm_component parent);
		super.new(name , parent);
	endfunction

  function void build_phase(uvm_phase phase);

	if(!uvm_config_db #(cs_mipi_config)::get(this,"","mipi_cfg",mipi_cfg))
      		`uvm_fatal("ppi_sub_env_config","getting failed")
    	agent = ppi_agent::type_id::create("agent",this);
	uvm_config_db #(ppi_config)::set(this,"*","ppi_cfg",mipi_cfg.ppi_cfg);
  endfunction
endclass