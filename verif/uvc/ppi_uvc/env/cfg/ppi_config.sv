class ppi_config extends uvm_object;
  `uvm_object_utils(ppi_config)

  virtual ppi_interface ppi_if;
  uvm_active_passive_enum is_active;

  function new(string name="ppi_config");
    super.new(name);
  endfunction
endclass