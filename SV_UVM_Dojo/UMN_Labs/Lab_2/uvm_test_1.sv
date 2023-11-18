class uvm_test_1 extends uvm_test;
  `uvm_component_utils(uvm_test_1)
    
    //uvm_cmpt_1 cmpt_1;
    //uvm_cmpt_2 cmpt_2;
  
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      //cmpt_1 = uvm_cmpt_1::type_id::create("cmpt_1", this);
      //cmpt_2 = uvm_cmpt_2::type_id::create("cmpt_2", this);
    endfunction
    
    task run_phase(uvm_phase phase);
      
      // We raise objection to keep the test from completing
      phase.raise_objection(this);
      #10;
      
      // We drop objection to allow the test to complete
      phase.drop_objection(this);
    endtask

endclass
  
