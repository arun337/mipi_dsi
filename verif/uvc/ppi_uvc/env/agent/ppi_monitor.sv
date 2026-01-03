class ppi_monitor extends uvm_monitor;
  `uvm_component_utils(ppi_monitor)

  // -------------------------------------------------
  // Config / Interface
  // -------------------------------------------------
  virtual ppi_interface.MON_MP vif;
  ppi_config ppi_cfg;

  // Analysis port (payload only)
  uvm_analysis_port #(ppi_xtn) mon_ap;

  // Internal byte queue
  byte byte_q[$];

  // FSM
  typedef enum {IDLE, COLLECT} state_t;
  state_t state;

  // -------------------------------------------------
  function new(string name="ppi_monitor", uvm_component parent);
    super.new(name,parent);
    mon_ap = new("mon_ap", this);
    state  = IDLE;
  endfunction

  // -------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(ppi_config)::get(this,"","ppi_cfg",ppi_cfg))
      `uvm_fatal("PPI_MON","ppi_cfg not found")
  endfunction

  // -------------------------------------------------
  function void connect_phase(uvm_phase phase);
    vif = ppi_cfg.ppi_if;
    if(vif == null)
      `uvm_fatal("PPI_MON","ppi_if is NULL")
  endfunction

  // -------------------------------------------------
  task run_phase(uvm_phase phase);
    ppi_xtn xtn;

    forever begin
      @(vif.mon_cb);

      /*if (!vif.mon_cb.valid)
        continue;*/

      // Sample one cycle of PPI data
      xtn = ppi_xtn::type_id::create("xtn", this);

      xtn.ppi_lane0_en   = vif.mon_cb.ppi_lane0_en;
      xtn.ppi_lane1_en   = vif.mon_cb.ppi_lane1_en;
      xtn.ppi_lane2_en   = vif.mon_cb.ppi_lane2_en;
      xtn.ppi_lane3_en   = vif.mon_cb.ppi_lane3_en;

      xtn.ppi_data_lane0 = vif.mon_cb.ppi_data_lane0;
      xtn.ppi_data_lane1 = vif.mon_cb.ppi_data_lane1;
      xtn.ppi_data_lane2 = vif.mon_cb.ppi_data_lane2;
      xtn.ppi_data_lane3 = vif.mon_cb.ppi_data_lane3;

      // Convert lanes ? byte stream
      collect_bytes(xtn);

      // Try decoding packets
      decode_packets();
    end
  endtask

  // -------------------------------------------------
  // Convert lane data into sequential byte stream
  // -------------------------------------------------
  task collect_bytes(ppi_xtn xtn);
    if (xtn.ppi_lane0_en) byte_q.push_back(xtn.ppi_data_lane0);
    if (xtn.ppi_lane1_en) byte_q.push_back(xtn.ppi_data_lane1);
    if (xtn.ppi_lane2_en) byte_q.push_back(xtn.ppi_data_lane2);
    if (xtn.ppi_lane3_en) byte_q.push_back(xtn.ppi_data_lane3);
  endtask

  // -------------------------------------------------
  // Decode packet and send ONLY payload
  // -------------------------------------------------
task decode_packets();
  int wc;
  int expected_sz;
  int hdr_idx;
  int payload_idx;     // ? DECLARED AT TOP
  ppi_xtn pkt;

  // Must at least have SoT
  if (byte_q.size() < 1)
    return;

  // Must start with SoT
  if (!(byte_q[0] == 8'h81 || byte_q[0] == 8'h01))
    return;

  // Must end with EoT
  if (!(byte_q[$] == 8'h81 || byte_q[$] == 8'h01))
    return;

  // Header index (before PAD + EoT)
  hdr_idx = byte_q.size() - 1 - 1 - 3;

  if (hdr_idx < 0)
    return;

  // Extract WC from header
  wc = { byte_q[hdr_idx+1], byte_q[hdr_idx] };

  // Expected total packet size
  expected_sz = 2 + 2 + wc + 3 + 2;

  if (byte_q.size() < expected_sz)
    return; // still collecting

  // Payload starts after SoT + PAD + CRC
  payload_idx = 2 + 2;

  repeat (wc) begin
    pkt = ppi_xtn::type_id::create("pkt", this);

    pkt.ppi_lane0_en   = 1;
    pkt.ppi_data_lane0 = byte_q[payload_idx++];

    pkt.ppi_lane1_en = 0;
    pkt.ppi_lane2_en = 0;
    pkt.ppi_lane3_en = 0;

    mon_ap.write(pkt);
  end

  // Clear for next packet
  byte_q.delete();
endtask

endclass