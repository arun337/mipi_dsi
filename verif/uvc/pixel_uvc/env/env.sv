class env extends uvm_env;
	`uvm_component_utils(env)
	
	env_config env_cfg;
  	pixel_agent pixel_agt;
	//rd_agent rd_agt;
	scoreboard sb;
	pixel_config pixel_cfg;
  	pixel_monitor mon;
	//rd_agent_cfg rd_agt_cfg;
	
	function new(string name="scoreboard", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal(get_full_name(),"get_method_failed");
      	pixel_agt = pixel_agent::type_id::create("pixel_agt",this);
      	uvm_config_db #(pixel_config)::set(this,"*","pixel_config",env_cfg.pixel_cfg);
		//rd_agt = rd_agent::type_id::create("rd_agt",this);
		//uvm_config_db #(rd_agent_cfg)::set(this,"*","rd_agent_cfg",env_cfg.rd_agt_cfg);
		if(env_cfg.has_sb)
			sb = scoreboard::type_id::create("sb",this);
          mon = pixel_monitor::type_id::create("mon", this);
	endfunction
  
    function void connect_phase(uvm_phase phase);
    //mon.mon_ap.connect(sb.sb_imp);
      
      mon.mon_ap.connect(sb.pix_fifo.analysis_export);
  endfunction
	
	/*function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(env_cfg.has_sb)
			wr_agt.wr_mon.wr_mon.connect(sb.wr_fifo.analysis_export);
			rd_agt.rd_mon.rd_mon.connect(sb.rd_fifo.analysis_export);
	endfunction
	*/
endclass