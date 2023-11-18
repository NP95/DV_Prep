class switch_test extends uvm_test;
 `uvm_component_utils(switch_test)
   
   //Declare the objects of switch_env and main_sequence classes

   function new(string name, uvm_component parent);
     super.new(name, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);

     //Instantiate env and main_sequence

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
    
     //Start the main_sequence by passing the sequencer as argument

     
     #1000;
     // We drop objection to allow the test to complete
     phase.drop_objection(this);
   endtask

endclass
 
