
`include "uvm_pkg.sv"

`include "svt_ahb.uvm.pkg"

`include "svt_ahb_if.svi"
`include "ahb_reset_if.svi"


`include "cs_mipi_dsi_test_pkg.sv"

`include "cs_mipi_if.sv"

module cs_mipi_dsi_top();

  import uvm_pkg::*;

  import cs_mipi_dsi_test_pkg::*;
  import svt_uvm_pkg::*;
  import svt_ahb_uvm_pkg::*;


  // -----------------------
  // Clock & Reset
  // -----------------------
  logic hclk = 0;
  logic pixel_clk = 0;
  //logic ppi_clk = 0;
  //bit reset = 0;
  bit dresetn =0;
bit rstn=0;

  initial begin
    
    forever #5 hclk = ~hclk;
	
  end

  initial begin

    forever #5 pixel_clk = ~pixel_clk;

  end

  /*initial begin

    forever #5  ppi_clk = ~ppi_clk;

  end*/

  /*initial begin
    // AHB reset MUST be asserted at t=0
    dresetn = 1;
    #10
    dresetn = 0;
	#100;
	dresetn = 1;
  end*/

initial begin 
rstn =0;
#200;
rstn =1;
end

	cs_mipi_dsi_if main_if(hclk , pixel_clk);

	

	ahb_reset_if ahb_reset_if();
	assign ahb_reset_if.clk = hclk;

	//assign main_if.ahb_if.hresetn = ahb_reset_if.resetn;

	assign main_if.ahb_if.hresetn = rstn;
	assign main_if.ahb_if.master_if[0].hgrant = 1;
    	



  // -----------------------
  // AHB VIP Interfacea
  // -----------------------
 /* svt_ahb_if ahb_if (
    .hclk    (hclk),
    .hresetn (hresetn)
  );*/

  // -----------------------
  // DUT Instance
  // -----------------------
  dsi #(
    .FRAME_LENGTH(10),
    .FRAME_WIDTH (10)
  ) u_dsi (
    .haddr   (main_if.ahb_if.master_if[0].haddr),
    .hwrite  (main_if.ahb_if.master_if[0].hwrite),
    .hsize   (main_if.ahb_if.master_if[0].hsize),
    .hburst  (main_if.ahb_if.master_if[0].hburst),
    .htrans  (main_if.ahb_if.master_if[0].htrans),
    .hwdata  (main_if.ahb_if.master_if[0].hwdata),
    .hprot   (main_if.ahb_if.master_if[0].hprot),
    .hrdata  (main_if.ahb_if.hrdata_bus),
    .hresp   (main_if.ahb_if.hresp_bus),
    .hready  (main_if.ahb_if.hready_bus),

    .pixel_data (main_if.pixel_if.pixel_data),
    .data_valid (main_if.pixel_if.dvalid),
    .hsync      (main_if.pixel_if.hsync),
    .vsync      (main_if.pixel_if.vsync),
    .pclk       (pixel_clk),
    .dsi_clk    (main_if.ppi_if.ppi_clk),
    .dsi_rst    (rstn),
    .ppi_data_lane0 (main_if.ppi_if.ppi_data_lane0),
    .ppi_data_lane1 (main_if.ppi_if.ppi_data_lane1),
    .ppi_data_lane2 (main_if.ppi_if.ppi_data_lane2),
    .ppi_data_lane3 (main_if.ppi_if.ppi_data_lane3),
    .ppi_lane0_en   (main_if.ppi_if.ppi_lane0_en),
    .ppi_lane1_en   (main_if.ppi_if.ppi_lane1_en),
    .ppi_lane2_en   (main_if.ppi_if.ppi_lane2_en),
    .ppi_lane3_en   (main_if.ppi_if.ppi_lane3_en)
  );

  // -----------------------
  // Dump
  // -----------------------
  initial begin
    if ($test$plusargs("ENABLE_DUMP")) begin
      `ifdef XCELIUM
        $shm_open("waves.shm", 1);
        $shm_probe("ASCTF");
      `else
        $fsdbDumpfile("mydump.fsdb");
        $fsdbDumpvars(0, cs_mipi_dsi_top);
      `endif
    end
  end


  initial begin
    // Wait until reset is released
    //@(posedge hresetn);

    
	uvm_config_db#(virtual pixel_interface)::set(null, "*", "pixel_if", main_if.pixel_if);
	uvm_config_db #(virtual svt_ahb_if)::set(uvm_root::get(),"*","vif",main_if.ahb_if);
	uvm_config_db #(virtual ppi_interface)::set(null,"*","ppi_if", main_if.ppi_if);

	uvm_config_db#(virtual ahb_reset_if.ahb_reset_modport)::set(uvm_root::get(), "uvm_test_top.mipi_env.ahb_env_h.sequencer", "reset_mp", ahb_reset_if.ahb_reset_modport);


	run_test();
  end





endmodule



