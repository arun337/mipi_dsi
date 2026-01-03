
interface pixel_if(input bit clk);
  	bit hsync, vsync, dvalid;
  	int unsigned pixel_data;
  	
  clocking drv_cb @(posedge clk);
    	default input #1 output #0;
    	output hsync, vsync, dvalid, pixel_data;
  endclocking
  
  clocking mon_cb @(posedge clk);
    	default input #1 output #0;
    	input hsync, vsync, dvalid, pixel_data;
  endclocking
  
  modport DRV_MP (clocking drv_cb);
  modport MON_MP (clocking mon_cb);
endinterface