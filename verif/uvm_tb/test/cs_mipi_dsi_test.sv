
`include "ahb_basic_wr_rd_seq.sv"

class cs_mipi_dsi_base_test extends uvm_test;
  `uvm_component_utils(cs_mipi_dsi_base_test)

  cs_mipi_dsi_env mipi_env;

  cs_mipi_config mipi_cfg;//main_config

  pixel_config pixel_cfg;
  ppi_config ppi_cfg;

  cust_svt_ahb_system_configuration  cfg;
	

  bit has_ahb = 1;
  bit has_pixel = 1;
  bit has_ppi = 1;
  bit has_sb = 1;

function new(string name="cs_mipi_dsi_base_test",uvm_component parent);
	super.new(name,parent);
endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

	cfg = cust_svt_ahb_system_configuration::type_id::create("cfg");

	$display("testing");

	uvm_config_db #(cust_svt_ahb_system_configuration)::set(this,"mipi_env.ahb_env_h", "cfg" , this.cfg);

  //uvm_config_db#(uvm_object_wrapper)::set(this, "mipi_env.ahb_env_h.ahb_system_env.sequencer.main_phase", "default_sequence", ahb_master_random_discrete_virtual_sequence::type_id::get());

  //uvm_config_db#(int unsigned)::set(this, "mipi_env.ahb_env_h.ahb_system_env.sequencer.ahb_master_random_discrete_virtual_sequence", "sequence_length", 50);

	mipi_cfg = cs_mipi_config::type_id::create("mipi_cfg");
 	mipi_env = cs_mipi_dsi_env::type_id::create("mipi_env",this);

	pixel_cfg = pixel_config::type_id::create("pixel_cfg");
	ppi_cfg = ppi_config::type_id::create("ppi_cfg");


if(!uvm_config_db #(virtual pixel_interface)::get(this,"","pixel_if",pixel_cfg.pixel_if))
	`uvm_fatal("Error","Error")

if(!uvm_config_db #(virtual ppi_interface)::get(this,"","ppi_if",ppi_cfg.ppi_if))
	`uvm_fatal("Error","Error")

/*if(!uvm_config_db #(virtual svt_ahb_if)::get(this,"","vif",cfg.ahb_vif))
	`uvm_fatal("Error","Error")*/

//$display("#######################################################################");
//$display("########getting ppi in test interface####### %p",pixel_cfg.pixel_if);

    

	pixel_cfg.is_active = UVM_ACTIVE;
	ppi_cfg.is_active = UVM_PASSIVE;
	
	
	mipi_cfg.has_ahb = has_ahb;
	mipi_cfg.has_pixel = has_pixel;
	mipi_cfg.has_ppi = has_ppi;
	mipi_cfg.has_sb = has_sb;
	
	

	mipi_cfg.pixel_cfg = pixel_cfg;
	mipi_cfg.ppi_cfg = ppi_cfg;
	//mipi_cfg.ahb_cfg = cfg;
	
    uvm_config_db#(cs_mipi_config)::set(this,"*","mipi_cfg",mipi_cfg);

 uvm_config_db#(uvm_object_wrapper)::set(this, "mipi_env.ahb_env_h.ahb_system_env.master*.sequencer.run_phase", "default_sequence", ahb_sam_init_seq::type_id::get());

   $display("cs_config %p",mipi_cfg);

  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology;
  endfunction


/*task run_phase(uvm_phase phase);
    //ahb_write_seq wr_seq;
    pixel_sequence pixel_seq;
    phase.raise_objection(this);
	$display("starting sequence....");
   
    pixel_seq = pixel_sequence::type_id::create("pixel_seq");
    pixel_seq.start(mipi_env.pixel_env_h.pixel_agt.pixel_seqrh);

$display("ending sequence...");
    phase.drop_objection(this);

$display("finishing sequence...");
//$finish();
endtask*/

task run_phase (uvm_phase phase);

pixel_sequence pixel_seq;
phase.raise_objection(this);
 
  begin

    pixel_seq = pixel_sequence::type_id::create("pixel_seq");
    pixel_seq.start(mipi_env.pixel_env_h.pixel_agt.pixel_seqrh);
  
   #40; 
  end
  
  phase.drop_objection(this);
endtask


/*function void report_phase(uvm_phase phase);
  super.report_phase(phase);
  `uvm_info("TEST", "Simulation finished cleanly", UVM_LOW)
  $finish;
endfunction*/

endclass


class directed_test extends cs_mipi_dsi_base_test;

  // Need to declare this property because some third-party simulators can't seem to
  // find enums defined in a class scope unless that class is declared somewhere in
  // that file or an included file.
  svt_ahb_transaction base_xact;  

  /** UVM Component Utility macro */
  `uvm_component_utils (directed_test)

  /** Class Constructor */
  function new (string name="directed_test", uvm_component parent=null);
    super.new (name, parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    `uvm_info ("build_phase", "Entered...",UVM_LOW)

    super.build_phase(phase);

    /**
     * Apply the null sequence to the System ENV virtual sequencer to override the
     * default sequence.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this, "mipi_env.ahb_env_h.ahb_system_env.sequencer.main_phase", "default_sequence", ahb_null_virtual_sequence::type_id::get());

    /** Apply the directed master sequence to the master sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "mipi_env.ahb_env_h.ahb_system_env.master*.sequencer.main_phase", "default_sequence", ahb_master_directed_sequence::type_id::get());

    /** Set the sequence 'length' to generate 50 directed transactions */
    //uvm_config_db#(int unsigned)::set(this, "mipi_env.ahb_env_h.ahb_system_env.master*.sequencer.ahb_master_directed_sequence", "sequence_length", 50);

    `uvm_info ("build_phase", "Exiting...",UVM_LOW)
  endfunction: build_phase





  
endclass



 
