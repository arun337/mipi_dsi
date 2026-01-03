
interface ppi_interface(input bit pclk);
	
logic [7:0] ppi_data_lane0;
logic [7:0] ppi_data_lane1;
logic [7:0] ppi_data_lane2;
logic [7:0] ppi_data_lane3;

clocking mon_cb @(posedge pclk);
	default input #1 output #0;
	input ppi_data_lane0, ppi_data_lane1;
	input ppi_data_lane2, ppi_data_lane3;
endclocking

modport MON_MP (clocking mon_cb);

endinterface
