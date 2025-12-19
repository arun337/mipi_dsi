class pixel_monitor extends uvm_monitor;
  `uvm_component_utils(pixel_monitor)

  virtual pixel_if.MON_MP vif;
  pixel_config pixel_cfg;

  uvm_analysis_port #(pixel_xtn) mon_ap;

  function new(string name="pixel_monitor", uvm_component parent);
    super.new(name, parent);
    mon_ap = new("mon_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(pixel_config)::get(this,"","pixel_config",pixel_cfg))
      `uvm_fatal(get_full_name(),"pixel_config not found");
  endfunction

  function void connect_phase(uvm_phase phase);
    vif = pixel_cfg.vif;
  endfunction

  task run_phase(uvm_phase phase);
    pixel_xtn xtn;

    forever begin
      @(vif.mon_cb);

      if (vif.mon_cb.dvalid || vif.mon_cb.hsync || vif.mon_cb.vsync) begin
        xtn = pixel_xtn::type_id::create("xtn", this);

        xtn.d_valid = vif.mon_cb.dvalid;
        xtn.h_sync  = vif.mon_cb.hsync;
        xtn.v_sync  = vif.mon_cb.vsync;
        xtn.p_data  = vif.mon_cb.pixel_data;

        mon_ap.write(xtn);

       // `uvm_info("PIXEL_MON",
         // $sformatf("MON: vsync=%0b hsync=%0b dvalid=%0b data=%0h",
          //  xtn.v_sync, xtn.h_sync, xtn.d_valid, xtn.p_data),
         // UVM_LOW)
        //xtn.print();
      end
    end
  endtask

endclass



/*class pixel_monitor extends uvm_monitor;
	`uvm_component_utils(pixel_monitor)
  
	virtual pixel_if.MON_MP vif;
	pixel_config pixel_cfg;
	pixel_xtn xtn;
	//uvm_analysis_port #(write_xtn) wr_mon;
	
	function new(string name="pixel_monitor", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      if(!uvm_config_db#(pixel_config)::get(this,"","pixel_config",pixel_cfg))
			`uvm_fatal(get_full_name(),"get_method_full");
		xtn=pixel_xtn::type_id::create("xtn");
		//wr_mon = new("wr_mon",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif = pixel_cfg.vif;
      
      $display("printing the virtual interface %p",vif);
	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			@(vif.act_mon_cb);
			xtn.sl = vif.act_mon_cb.sl;
			xtn.sel = vif.act_mon_cb.sel;
			xtn.pi = vif.act_mon_cb.pi;
			xtn.out = vif.act_mon_cb.out;
			wr_mon.write(xtn);
			`uvm_info("WR_Monitor",$sformatf("printing from wr_MON \n %s", xtn.sprint()),UVM_LOW)
		end
	endtask
	

endclass*/