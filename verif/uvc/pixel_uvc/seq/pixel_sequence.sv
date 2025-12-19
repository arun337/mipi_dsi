class pixel_sequence extends uvm_sequence#(pixel_xtn);
  `uvm_object_utils(pixel_sequence)
  
  pixel_xtn xtn;
  function new(string name="pixel_sequence");
    super.new(name);
  endfunction
  
  task body();
    xtn = pixel_xtn::type_id::create("xtn");
    repeat(3) begin
    start_item(xtn);
    assert(xtn.randomize());
    finish_item(xtn);
    end
  endtask
endclass