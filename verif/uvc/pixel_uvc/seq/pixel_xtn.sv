class pixel_xtn extends uvm_sequence_item;
  `uvm_object_utils(pixel_xtn);
  
   function new(string name = "pixel_xtn");
    super.new(name); 
  endfunction
  
  bit v_sync, h_sync, d_valid;
  int p_data;
  
  int unsigned vtotal, htotal;
  int hbe,hbs;
  int vbe,vbs;
  int hwidth, vwidth;
  int pixel_width, pixel_depth;
  int unsigned a,b;
  
  typedef enum {HD, SD, WVGA, VGA, QVGA, CIF, QCIF, QQVGA, SAM} pixel;
  rand pixel resolution;
  
  constraint c1 {resolution == SAM;};
  
  function void post_randomize();
    
     
    if(resolution == HD)
      begin
        pixel_width = 1280;
        pixel_depth = 720;
        htotal = 1300;
        //vtotal = 936000;
        hbe = 15;
        hbs = 1295;
        //vbe = 15;
        //vbs = 935995;
        hwidth = 10;
        vwidth = 10;
      end
    
    if(resolution == SD)
      begin
        pixel_width = 720;
        pixel_depth = 480;
        htotal = 740;
        //vtotal = 490800;
        hbe = 15;
        hbs = 735;
        //vbe = 13;
        //vbs = 490795;
        hwidth = 10;
        vwidth = 10;
      end
    
    if(resolution == WVGA)
      begin
        pixel_width = 720;
        pixel_depth = 480;
        htotal = 740;
        //vtotal = 392640;
        hbe = 15;
        hbs = 735;
        //vbe = 13;
       // vbs = 392635;
        hwidth = 10;
        vwidth = 10;
      end
    
    if(resolution == VGA)
      begin
        pixel_width = 640;
        pixel_depth = 480;
        htotal = 660;
       // vtotal = 314400;
        hbe = 15; 
        hbs = 655; 
       // vbe = 10;
       // vbs = 314395;
        hwidth = 10;
        vwidth = 10;
      end
    
    if(resolution == CIF)
      begin
        pixel_width = 352;
        pixel_depth = 288;
        htotal = 367;
        hbe = 10;
        hbs = 362;
        hwidth = 5;
        vwidth = 5;
      end
    
    if(resolution == QVGA)
      begin
        pixel_width = 320;
        pixel_depth = 240;
        htotal = 335;
        hbe = 10;
        hbs = 330;
        hwidth = 5;
        vwidth = 5;
      end
    
    if(resolution == QCIF)
      begin
        pixel_width = 176;
        pixel_depth = 144;
        htotal = 191;
        hbe = 10;
        hbs = 186;
        hwidth = 5;
        vwidth = 5;
      end
    
    if(resolution == QQVGA)
      begin
        pixel_depth = 120;
        pixel_width = 160;
        hwidth = 10;
        vwidth = 10;
        hbe = hwidth + 5;
        hbs = hbe + pixel_width;
        htotal = hbs + 5;
      end
    
    if(resolution == SAM)
      begin
        pixel_depth = 10;
        pixel_width = 10;
        hwidth = 10;
        vwidth = 10;
        hbe = hwidth + 5;
        hbs = hbe + pixel_width;
        htotal = hbs + 5;
      end
  endfunction
  
  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("RESOLUTION", this.resolution, 08, UVM_DEC);
    printer.print_field("pixel_width", this.pixel_width, 32, UVM_DEC);
    printer.print_field("pixel_depth", this.pixel_depth, 32, UVM_DEC);
    printer.print_field("pixel_htotal", this.htotal, 32, UVM_DEC);
    printer.print_field("pixel_hbe", this.hbe, 32, UVM_DEC);
    printer.print_field("pixel_hbs", this.hbs, 32, UVM_DEC);
    printer.print_field("pixel_hwidth", this.hwidth, 32, UVM_DEC);
    printer.print_field("pixel_vwidth", this.vwidth, 32, UVM_DEC);
  endfunction
endclass