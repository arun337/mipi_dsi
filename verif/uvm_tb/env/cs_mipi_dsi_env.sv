class cs_mipi_dsi_env extends uvm_env;
  `uvm_component_utils(cs_mipi_dsi_env)

  cs_mipi_config   mipi_cfg;
  

  ahb_basic_env  ahb_env_h;
  pixel_env  pixel_env_h;
  ppi_env  ppi_env_h;

  mipi_dsi_scoreboard sb;



function new(string name="cs_mipi_dsi_env",uvm_component parent);
	super.new(name,parent);
endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(cs_mipi_config)::get(this,"","mipi_cfg",mipi_cfg))
      `uvm_fatal("CFG","cs_cfg missing")

$display("displaying config %p",mipi_cfg);

	if(mipi_cfg.has_ahb) begin
		//uvm_config_db #(ahb_config)::set(this,"*","ahb_config",mipi_cfg.ahb_cfg);
      		ahb_env_h = ahb_basic_env::type_id::create("ahb_env_h",this);
	end

	if(mipi_cfg.has_ppi) begin
		//uvm_config_db #(ppi_config)::set(this,"*","ppi_config",mipi_cfg.ppi_cfg);
		ppi_env_h = ppi_env::type_id::create("ppi_env_h",this);
		
	end

	if(mipi_cfg.has_pixel) begin
		//uvm_config_db #(pixel_config)::set(this,"*","pixel_config",mipi_cfg.pixel_cfg);
		pixel_env_h = pixel_env::type_id::create("pixel_env_h",this);

	end

	if(mipi_cfg.has_sb) 
		sb =mipi_dsi_scoreboard::type_id::create("sb",this);
   endfunction


  /*function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    pixel_env_h.pixel_agnth.monh.analysis_port.connect(pixel_sb.fifo_pixel.analysis_export);
  endfunction*/


function void connect_phase(uvm_phase phase);
  pixel_env_h.pixel_agt.pixel_mon.mon_ap.connect(sb.pix_imp);
  ppi_env_h.agent.mon.mon_ap.connect(sb.ppi_imp);
endfunction

endclass