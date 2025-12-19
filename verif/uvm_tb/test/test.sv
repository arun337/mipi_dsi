class test extends uvm_test;
	`uvm_component_utils(test)
	
	env envh;
	env_config env_cfg;
	pixel_config pixel_cfg;
  	 pixel_sequence pixel_seq;
	//rd_agent_cfg rd_agt_cfg;
	int has_sb =1;
	int pixel_agt =1;
	int rd_agt =1;
	
	function new(string name ="test",uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		envh = env::type_id::create("envh",this);
		env_cfg = env_config::type_id::create("env_cfg");
		
		
		
      if(pixel_agt) begin
        pixel_cfg = pixel_config::type_id::create("pixel_cfg");
        if(!uvm_config_db#(virtual pixel_if)::get(this,"","vif",pixel_cfg.vif))
				`uvm_fatal(get_full_name(),"get method failed");
			env_cfg.pixel_cfg=pixel_cfg; // here in test i created the object for agent, and i pointing the same object to the handle present in env_config so, when ever i want to create an object for agents, simply i can get the env_config and use the agents
			pixel_cfg.is_active = UVM_ACTIVE;
      end
			
		/*if(rd_agt)
			rd_agt_cfg = rd_agent_cfg::type_id::create("rd_agt_cfg");
			if(!uvm_config_db#(virtual uni_sft_if)::get(this,"","vif",rd_agt_cfg.vif))
				`uvm_fatal(get_full_name(),"get method failed");
			env_cfg.rd_agt_cfg=rd_agt_cfg;
			rd_agt_cfg.is_active = UVM_PASSIVE;
		*/
		env_cfg.has_sb = has_sb;
		
		uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg);
	endfunction
    
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    pixel_seq = pixel_sequence::type_id::create("pixel_seq");
    pixel_seq.start(envh.pixel_agt.pixel_seqrh);
    #10000;
    phase.drop_objection(this);
  endtask
  
  	
endclass

/*class rand_test extends test;
  `uvm_component_utils (rand_test)
    
  pixel_sequence pixel_seq;
  
  function new(string name ="rand_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    pixel_seq = pixel_sequence::type_id::create("pixel_seq");
    pixel_seq.start(envh.pixel_agt.pixel_seqrh);
    #1000;
    phase.drop_objection(this);
  endtask
  
endclass

//##########################################################################//

class reset_test extends test;
	`uvm_component_utils(reset_test)
	
	reset_sequence rst_seqh;
	
	function new(string name="reset_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		rst_seqh = reset_sequence::type_id::create("rst_seqh");
		rst_seqh.start(envh.wr_agt.wr_seqrh);
		#40;
		phase.drop_objection(this);
	endtask
endclass

class rand_test extends test;
	`uvm_component_utils(rand_test)
	
	wr_sequence wr_seqh;
	
	function new(string name="rand_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		wr_seqh = wr_sequence::type_id::create("wr_seqh");
		wr_seqh.start(envh.wr_agt.wr_seqrh);
		#40;
		phase.drop_objection(this);
	endtask
endclass

class left_test extends test;
	`uvm_component_utils(left_test)
	
	left_sequence sl_seqh;
	
	function new(string name="left_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		sl_seqh = left_sequence::type_id::create("sl_seqh");
		sl_seqh.start(envh.wr_agt.wr_seqrh);
		#40;
		phase.drop_objection(this);
	endtask
endclass

class right_test extends test;
	`uvm_component_utils(right_test)
	
	right_sequence sr_seqh;
	
	function new(string name="right_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		sr_seqh = right_sequence::type_id::create("sr_seqh");
		sr_seqh.start(envh.wr_agt.wr_seqrh);
		#40;
		phase.drop_objection(this);
	endtask
endclass

class pipo_test extends test;
	`uvm_component_utils(pipo_test)
	
	pipo_sequence pipo_seqh;
	
	function new(string name="pipo_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		pipo_seqh = pipo_sequence::type_id::create("pipo_seqh");
		pipo_seqh.start(envh.wr_agt.wr_seqrh);
		#40;
		phase.drop_objection(this);
	endtask
endclass
*/