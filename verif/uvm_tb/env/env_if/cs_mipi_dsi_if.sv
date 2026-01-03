interface cs_mipi_dsi_if(input bit hclk  , input bit pixel_clk );


pixel_interface pixel_if(pixel_clk);

ppi_interface ppi_if();

svt_ahb_if ahb_if();
assign ahb_if.hclk = hclk;
//assign ahb_if.hresetn = hresetn;

endinterface 