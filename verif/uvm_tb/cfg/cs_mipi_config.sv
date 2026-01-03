
class cs_mipi_config extends uvm_object;
  `uvm_object_utils(cs_mipi_config)

  bit has_ahb;
  bit has_pixel;
  bit has_ppi;
  bit has_sb;
  
  pixel_config pixel_cfg;
  ppi_config ppi_cfg;
  cust_svt_ahb_system_configuration ahb_cfg;

  function new(string name="cs_mipi_config");
    super.new(name);
  endfunction

endclass