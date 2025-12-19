class pixel_sequencer extends uvm_sequencer#(pixel_xtn);
	`uvm_component_utils(pixel_sequencer)
	
	function new(string name ="pixel_sequencer", uvm_component parent=null);
		super.new(name,parent);
	endfunction
endclass