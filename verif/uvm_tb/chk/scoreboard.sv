`uvm_analysis_imp_decl(_pixel)
`uvm_analysis_imp_decl(_ppi)

class mipi_dsi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(mipi_dsi_scoreboard)

  uvm_analysis_imp_pixel #(pixel_xtn, mipi_dsi_scoreboard) pix_imp;
  uvm_analysis_imp_ppi   #(ppi_xtn,   mipi_dsi_scoreboard) ppi_imp;

  byte exp_q[$];
  byte act_q[$];

  function new(string name, uvm_component parent);
    super.new(name,parent);
    pix_imp = new("pix_imp", this);
    ppi_imp = new("ppi_imp", this);
  endfunction

  // -------------------------------------------------
  // Pixel monitor ? expected data
  // -------------------------------------------------
  function void write_pixel(pixel_xtn xtn);
    if (xtn.d_valid)
      exp_q.push_back(xtn.p_data[7:0]);
  endfunction

  // -------------------------------------------------
  // PPI monitor ? actual data
  // -------------------------------------------------
  function void write_ppi(ppi_xtn xtn);
    // Payload-only assumption:
    // Monitor sends one payload byte per xtn on lane0
    if (xtn.ppi_lane0_en)
      act_q.push_back(xtn.ppi_data_lane0);
  endfunction

  // -------------------------------------------------
  task run_phase(uvm_phase phase);
    byte exp, act;

    forever begin
      wait (exp_q.size() > 0 && act_q.size() > 0);

      exp = exp_q.pop_front();
      act = act_q.pop_front();

      if (exp !== act)
        `uvm_error("MIPI_DSI_SB",
          $sformatf("DATA MISMATCH EXP=%0h ACT=%0h", exp, act))
      else
        `uvm_info("MIPI_DSI_SB",
          $sformatf("DATA MATCH %0h", exp),
          UVM_LOW)
    end
  endtask

endclass