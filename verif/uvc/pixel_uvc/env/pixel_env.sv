class pixel_env extends uvm_env;
	`uvm_component_utils(pixel_env)
	
  	pixel_agent pixel_agt;
	//pixel_config pixel_cfg;

	cs_mipi_config mipi_cfg;
 	
	function new(string name="pixel_env", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	if(!uvm_config_db #(cs_mipi_config)::get(this,"","mipi_cfg",mipi_cfg))
      		`uvm_fatal("sub_env_config","getting failed")
      		pixel_agt = pixel_agent::type_id::create("pixel_agt",this);

	uvm_config_db #(pixel_config)::set(this,"*","pixel_cfg",mipi_cfg.pixel_cfg);

	$display("####################");
		$display("pixel config from env %p",mipi_cfg);

	$display("####################");
		$display("pixel config from env %p",mipi_cfg.pixel_cfg);


	endfunction

  
endclass