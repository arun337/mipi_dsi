class pixel_driver extends uvm_driver#(pixel_xtn);
  `uvm_component_utils(pixel_driver)
	
	virtual pixel_if.DRV_MP vif;
	pixel_config pixel_cfg;
  	//int c;
	
	function new(string name="pixel_driver", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      if(!uvm_config_db#(pixel_config)::get(this,"","pixel_config",pixel_cfg))
			`uvm_fatal(get_full_name(),"get_method_failed");
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif = pixel_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);

		forever begin
          	seq_item_port.get_next_item(req);
          $display("value of req = %p \n",req);
          	send_to_dut(req);
			seq_item_port.item_done();
          end
	endtask
	
  task send_to_dut(pixel_xtn xtn);
		fork 
          vsync_task(xtn);
          
          
            hsync_task(xtn); 
          

            data_task(xtn); 
        join
    `uvm_info("Driver",$sformatf("printing from Pixel_driver \n %s", xtn.sprint()),UVM_LOW)
	endtask
  
  	task vsync_task(pixel_xtn xtn);
      	
      repeat(xtn.vwidth) begin  
        @(vif.drv_cb);
      	vif.drv_cb.vsync <= 1'b1;
      end
      @(vif.drv_cb);
      vif.drv_cb.vsync <= 1'b0;
  	endtask
  
  	task hsync_task(pixel_xtn xtn);
      	int h_2_h;
      	h_2_h = xtn.htotal - xtn.hwidth;
      $display("h_2_h =%0d",h_2_h);
      
      repeat(xtn.pixel_depth) begin
        	
        
      repeat(xtn.hwidth) begin
        @(vif.drv_cb);
        vif.drv_cb.hsync <= 1'b1;
      end 	
        //@(vif.drv_cb);
      repeat(h_2_h) begin
        @(vif.drv_cb);
        vif.drv_cb.hsync <= 1'b0; end
      end
     
    endtask
  
  task data_task(pixel_xtn xtn);
    int b;
    b = xtn.htotal - xtn.hbs;
    $display("value of b =%0d", b);
    
    repeat(xtn.pixel_depth) begin
      
    repeat(xtn.hbe) begin
       @(vif.drv_cb);
     	vif.drv_cb.dvalid <= 1'b0;
      vif.drv_cb.pixel_data <= 'b0;
    end
    
    repeat(xtn.pixel_width) begin
       @(vif.drv_cb);
      vif.drv_cb.dvalid <= 1'b1;
      vif.drv_cb.pixel_data <= $urandom;
    end
     
      repeat((xtn.htotal) - (xtn.hbs)) begin
      	 @(vif.drv_cb);
        vif.drv_cb.dvalid <= 1'b0;
      	vif.drv_cb.pixel_data <= 'b0;	
      
    end
      
    end
    
  endtask

endclass