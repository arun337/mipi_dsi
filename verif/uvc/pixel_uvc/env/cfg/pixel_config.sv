class pixel_config extends uvm_object;
  `uvm_object_utils(pixel_config)
	virtual pixel_if vif;
	uvm_active_passive_enum is_active;
	
  function new(string name="pixel_config");
		super.new(name);
	endfunction
endclass