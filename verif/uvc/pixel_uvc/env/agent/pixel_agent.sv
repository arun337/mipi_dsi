class pixel_agent extends uvm_agent;
	`uvm_component_utils(pixel_agent)
	
	pixel_config pixel_cfg;
	pixel_driver pixel_drv;
	pixel_monitor pixel_mon;
	pixel_sequencer pixel_seqrh;
	
	function new(string name="pixel_agent", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      if(!uvm_config_db #(pixel_config)::get(this,"","pixel_config",pixel_cfg))
			`uvm_fatal(get_full_name(),"get_method_failed");
			
      if(pixel_cfg.is_active == UVM_ACTIVE) begin
			pixel_drv = pixel_driver::type_id::create("pixel_drv",this);
			pixel_seqrh = pixel_sequencer::type_id::create("pixel_seqrh",this);
		end
		
		pixel_mon = pixel_monitor::type_id::create("pixel_mon",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(pixel_cfg.is_active == UVM_ACTIVE)
			pixel_drv.seq_item_port.connect(pixel_seqrh.seq_item_export);
	endfunction
endclass