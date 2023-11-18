class ram_driver_new extends ram_driver #(ram_transaction);

  `uvm_component_utils(ram_driver_new)

 function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);

   //Complete the run_phase code 

  endtask

endclass: ram_driver_new

