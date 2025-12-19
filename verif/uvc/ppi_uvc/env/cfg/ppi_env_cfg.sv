class ppi_env_config extends uvm_object;
	`uvm_object_utils(ppi_env_config)
	
	int has_sb;
	ppi_config ppi_cfg; 
	//rd_agent_cfg rd_agt_cfg;
	
	function new(string name = "ppi_env_config");
		super.new(name);
	endfunction
endclass