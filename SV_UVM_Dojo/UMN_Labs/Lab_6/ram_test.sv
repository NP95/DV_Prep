class ram_test extends uvm_test;
 `uvm_component_utils(ram_test)
   
   ram_env env;
   ram_sequence ram_seq;

   function new(string name, uvm_component parent);
     super.new(name, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
     env = ram_env::type_id::create("env", this);
     ram_seq = ram_sequence::type_id::create("ram_seq");
   endfunction

   function void end_of_elaboration_phase(uvm_phase phase);
     print();
   endfunction
   
   
   task run_phase(uvm_phase phase);
     
     // We raise objection to keep the test from completing
     phase.raise_objection(this);
     `uvm_warning("", "RAM test!")
     #10;
    
     ram_seq.start(env.agent.sequencer);
     
     #1000;
     // We drop objection to allow the test to complete
     phase.drop_objection(this);
   endtask

endclass
 
