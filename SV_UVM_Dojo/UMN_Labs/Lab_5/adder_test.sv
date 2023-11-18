class adder_test extends uvm_test;
  `uvm_component_utils(adder_test)
  
  adder_env env;
  adder_sequence seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    env = adder_env::type_id::create("env", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    // We raise objection to keep the test from completing
    phase.raise_objection(this);
    `uvm_warning("", "ADDER test!")

    //Start the sequence

    #10;
    // We drop objection to allow the test to complete
    phase.drop_objection(this);
  endtask

endclass
