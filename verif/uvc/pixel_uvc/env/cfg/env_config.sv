class pixel_env_config extends uvm_object;
	`uvm_object_utils(pixel_env_config)
	
	int has_sb;
	pixel_config pixel_cfg; 
	//rd_agent_cfg rd_agt_cfg;
	
	function new(string name = "pixel_env_config");
		super.new(name);
	endfunction
endclass