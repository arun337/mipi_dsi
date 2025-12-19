module cs_mipi_dsi_top();
  import uvm_pkg::*;
   bit clock;
   

   initial begin

   forever #5ns clock = ~clock; 

   end

   initial begin
	#1000ns;
	$finish;
   end

  initial begin
 
   if($test$plusargs("ENABLE_DUMP")) begin
    `ifdef XCELIUM
       $shm_open("waves.shm", 1);
       $shm_probe("ASCTF");
    `else
       $fsdbDumpfile("./mydump.fsdb");
       $fsdbDumpvars; 
    `endif
    end

  end

  dsi#(.FRAME_LENGTH(1280), .FRAME_WIDTH(720))
(
  .haddr(),
  .hwrite(), 
  .hsize(),   
  .hburst(),
  .htrans(),
  .hwdata(),
  .hprot(),
  .hresp(),
  .hready(),
  .pixel_data(),
  .data_valid(),
  .hsync(),
  .vsync(),
  .pclk(),
  .dsi_clk(),
  .dsi_rst(),
  .ppi_data_lane0(),
  .ppi_data_lane1(),
  .ppi_data_lane2(),
  .ppi_data_lane3(),
  .ppi_lane0_en(),
  .ppi_lane1_en(),
  .ppi_lane2_en(),
  .ppi_lane3_en()
);


endmodule 
