`ifndef GUARD_AHB_SAM_INIT_SEQ_SV
`define GUARD_AHB_SAM_INIT_SEQ_SV

class ahb_sam_init_seq extends svt_ahb_master_transaction_base_sequence;
  `uvm_object_utils(ahb_sam_init_seq)

  function new(string name="ahb_sam_init_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Starting AHB SAM init sequence", UVM_MEDIUM)
    super.body();

    // -------------------------------------------------
    // 1. Disable DSI (dsi_ctrl0 = 0)
    // addr[4] = 0x4000_0010
    // -------------------------------------------------
    `uvm_do_with(req, {
      xact_type  == svt_ahb_transaction::WRITE;
      burst_type == svt_ahb_transaction::SINGLE;
      burst_size == svt_ahb_transaction::BURST_SIZE_32BIT;
      //trans_type == svt_ahb_transaction::NONSEQ;
      addr       == 32'h4000_0010;
      data.size() == 1;
      data[0]    == 32'h0000_0000;
    })

    // -------------------------------------------------
    // 2. Program Word Count (SAM ? 10 pixels ? 30 bytes)
    // dsi_lng
    // addr[3] = 0x4000_000C
    // -------------------------------------------------
    `uvm_do_with(req, {
      xact_type  == svt_ahb_transaction::WRITE;
      burst_type == svt_ahb_transaction::SINGLE;
      burst_size == svt_ahb_transaction::BURST_SIZE_32BIT;
     // trans_type == svt_ahb_transaction::NONSEQ;
      addr       == 32'h4000_000C;
      data.size() == 1;
      data[0]    == 32'h0000_001E; // 30 bytes
    })

    // -------------------------------------------------
    // 3. Program DSI Command (Long write ? 0x39)
    // dsi_cmd
    // addr[2] = 0x4000_0008
    // -------------------------------------------------
    `uvm_do_with(req, {
      xact_type  == svt_ahb_transaction::WRITE;
      burst_type == svt_ahb_transaction::SINGLE;
      burst_size == svt_ahb_transaction::BURST_SIZE_32BIT;
      //trans_type == svt_ahb_transaction::NONSEQ;
      addr       == 32'h4000_0008;
      data.size() == 1;
      data[0]    == 32'h0000_0039;
    })

    // -------------------------------------------------
    // 4. Enable DSI (dsi_ctrl0 = 1)
    // addr[4] = 0x4000_0010
    // -------------------------------------------------
    `uvm_do_with(req, {
      xact_type  == svt_ahb_transaction::WRITE;
      burst_type == svt_ahb_transaction::SINGLE;
      burst_size == svt_ahb_transaction::BURST_SIZE_32BIT;
      //trans_type == svt_ahb_transaction::NONSEQ;
      addr       == 32'h4000_0010;
      data.size() == 1;
      data[0]    == 32'h0000_0001;
    })

    `uvm_info(get_type_name(), "AHB SAM init sequence DONE", UVM_MEDIUM)
  endtask

endclass

`endif // GUARD_AHB_SAM_INIT_SEQ_SV






