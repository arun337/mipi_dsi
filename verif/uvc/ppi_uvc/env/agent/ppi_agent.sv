class ppi_agent extends uvm_agent;
  `uvm_component_utils(ppi_agent)

  ppi_monitor mon;

function new(string name="ppi_agent", uvm_component parent);
		super.new(name,parent);
endfunction

  function void build_phase(uvm_phase phase);
    mon = ppi_monitor::type_id::create("mon",this);
  endfunction
endclass




