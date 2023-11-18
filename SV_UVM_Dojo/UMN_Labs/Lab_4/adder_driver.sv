class adder_driver extends uvm_driver;

  //Register the class using uvm_component_utils


  //Define virtual interface

  function new(string name, uvm_component parent);

    //Call super.new

  endfunction

  function void build_phase(uvm_phase phase);

    // Get virtual interface reference from config database

  endfunction 

  task run_phase(uvm_phase phase);
    
    
      // Wiggle pins of DUT

  endtask

endclass: adder_driver

