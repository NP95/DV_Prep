class switch_test extends uvm_test;
  `uvm_component_utils(switch_test)
   
  //Objects declaration for switch_env and main_sequence classes
  switch_env env;
  main_sequence main_seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
   
  function void build_phase(uvm_phase phase);
    //Instantiate env and main_sequence
    env = switch_env::type_id::create("env", this);
    main_seq = main_sequence::type_id::create("main_seq");

    //Call Override functions

  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    print();
  endfunction
   
   
  task run_phase(uvm_phase phase);
     
    // We raise objection to keep the test from completing
    phase.raise_objection(this);
    `uvm_warning("", "SWITCH test!")
    #10;
    
    //Starting the main_sequence by passing the sequencer as argument
    main_seq.start(env.input_agent.sequencer);
     
    #1000;
    // We drop objection to allow the test to complete
    phase.drop_objection(this);
  endtask

endclass
 
