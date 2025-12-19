class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  // Analysis FIFO
  uvm_tlm_analysis_fifo #(pixel_xtn) pix_fifo;

  // Queue for pixel data
  logic pixel_data_q[$];

  function new(string name="scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    pix_fifo = new("pix_fifo", this);
  endfunction

  task run_phase(uvm_phase phase);
    pixel_xtn xtn;

    forever begin
      pix_fifo.get(xtn);   // Blocking get from FIFO

      if (xtn.d_valid) begin
        pixel_data_q.push_back(xtn.p_data);

        `uvm_info("PIXEL_SCB",
          $sformatf("Stored pixel = %0h | Qsize=%0d",
            xtn.p_data, pixel_data_q.size()),
          UVM_LOW)
      end
    end
  endtask

endclass


/*class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(pixel_xtn, scoreboard) sb_imp;

  // Queue for pixel data 
  logic [31:0] pixel_data_q[$];   

  function new(string name="scoreboard", uvm_component parent);
    super.new(name, parent);
    sb_imp = new("sb_imp", this);
  endfunction

  function void write(pixel_xtn xtn);
    if (xtn.d_valid) begin
      pixel_data_q.push_back(xtn.p_data);

      `uvm_info("PIXEL_SCB",
        $sformatf("Stored pixel = %0h | Qsize=%0d",
          xtn.p_data, pixel_data_q.size()),
        UVM_LOW)
    end
  endfunction

endclass*/

/*class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(pixel_xtn, scoreboard) sb_imp;

  bit prev_vsync;
  bit prev_hsync;

  int pixel_cnt;
  int line_cnt;
  int frame_cnt;

  bit error_seen;  

  function new(string name="scoreboard", uvm_component parent);
    super.new(name, parent);
    sb_imp = new("sb_imp", this);
  endfunction

  function void write(pixel_xtn xtn);


    if (!prev_vsync && xtn.v_sync) begin
      if (frame_cnt > 0) begin
        $display("FRAME %0d PASS", frame_cnt);
      end
      frame_cnt++;
      line_cnt  = 0;
      pixel_cnt = 0;
      $display("NEW FRAME STARTED: frame=%0d", frame_cnt);
    end


    if (!prev_hsync && xtn.h_sync) begin
      if (line_cnt > 0) begin
       // $display("LINE %0d PASS (pixels=%0d)", line_cnt, pixel_cnt);
      end
      line_cnt++;
      pixel_cnt = 0;
    end


    if (xtn.d_valid) begin
      pixel_cnt++;

      if (xtn.p_data === 'x) begin
        error_seen = 1;
        xtn.print();  // printer-based
        $display("DATA ERROR: X detected");
      end
    end

    prev_vsync = xtn.v_sync;
    prev_hsync = xtn.h_sync;

  endfunction

  function void report_phase(uvm_phase phase);
    if (!error_seen) begin
      $display("====================================");
      $display(" PIXEL PROTOCOL CHECK : PASSED ");
      $display(" Frames Checked : %0d", frame_cnt);
      $display(" Lines Checked  : %0d", line_cnt);
      $display("====================================");
    end
    else begin
      $display("====================================");
      $display(" PIXEL PROTOCOL CHECK : FAILED ");
      $display("====================================");
    end
  endfunction

endclass*/