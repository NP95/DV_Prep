class adder_test extends uvm_test;

  //Register the test using uvm_component_utils
  

  //Define an object of type adder_driver

  function new(string name, uvm_component parent);

    //Call super.new

  endfunction
  
  function void build_phase(uvm_phase phase);

    //Instantiate the driver object using create task

  endfunction
  
  task run_phase(uvm_phase phase);

    // raise objection 

    `uvm_warning("", "ADDER test!")
    #10;

    //drop objection

  endtask

endclass
