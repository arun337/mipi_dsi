class test extends uvm_test;
	`uvm_component_utils(test)

	//PIXEL SIGNALS
	pixel_env envh;
	pixel_env_config env_cfg;
	pixel_config pixel_cfg;
  	pixel_sequence pixel_seq;

	//PPI SIGNALS
	ppi_env ppi_envh;
	ppi_env_config ppi_ecfg;
	ppi_config ppi_cfg;
	ppi_sequence ppi_seq;

	//rd_agent_cfg rd_agt_cfg;
	int has_sb =1;

	//pixel parameters
	int pixel_agt =1;
	int rd_agt =1;

	//ppi parameters
	int ppi_agent = 1;


	function new(string name ="test",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		//creating env for pixel
		envh = pixel_env::type_id::create("envh",this);
		env_cfg =pixel_env_config::type_id::create("env_cfg");
		
		//creating env for ppi
		ppi_envh = ppi_env::type_id::create("ppi_envh",this);
		ppi_ecfg = ppi_env_config::type_id::create("ppi_ecfg",this);
		
      	//creting pixel agent
		if(pixel_agt) begin
        	pixel_cfg = pixel_config::type_id::create("pixel_cfg");
        	if(!uvm_config_db#(virtual pixel_if)::get(this,"","vif",pixel_cfg.vif))
				`uvm_fatal(get_full_name(),"get method failed");
			env_cfg.pixel_cfg=pixel_cfg; // here in test i created the object for agent, and i pointing the same object to the handle present in env_config so, when ever i want to create an object for agents, simply i can get the env_config and use the agents
			pixel_cfg.is_active = UVM_ACTIVE;
      	end

		//creating ppi agent
		if(ppi_agent) begin
			ppi_cfg = ppi_config::type_id::create("ppi_cfg");
			if(!uvm_config_db#(virtual ppi_if)::get(this,"","vif_1",ppi_cfg.vif))
				`uvm_fatal(get_full_name(),"get method failed")
			ppi_cfg.is_active = UVM_PASSIVE;
			ppi_ecfg.ppi_cfg = ppi_cfg;
		end
			
		env_cfg.has_sb = has_sb;
		
		//setting config_db 
		uvm_config_db #(pixel_env_config)::set(this,"*","pixel_env_config",env_cfg);
		uvm_config_db #(ppi_env_config)::set(this,"*","ppi_env_config",ppi_ecfg);

	endfunction
    
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
	pixel_seq = pixel_sequence::type_id::create("pixel_seq");
	ppi_seq = ppi_sequence::type_id::create("ppi_seq");
    phase.raise_objection(this);
   
    pixel_seq.start(envh.pixel_agt.pixel_seqrh);
	ppi_seq.start(ppi_envh.ppi_agnth.ppi_seqrh);
    #10000;
    phase.drop_objection(this);
  endtask
  
  	
endclass


