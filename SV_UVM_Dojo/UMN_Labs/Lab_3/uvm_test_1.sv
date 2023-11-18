class uvm_test_1 extends uvm_test;
  `uvm_component_utils(uvm_test_1)
    
    uvm_reporting rpt;
  
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      rpt = uvm_reporting::type_id::create("rpt", this);
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
      //rpt.set_report_verbosity_level(UVM_MEDIUM); 
    endfunction

    task run_phase(uvm_phase phase);
      
      // We raise objection to keep the test from completing
      phase.raise_objection(this);
      #10;
      `uvm_warning("", "UVM test!")
      
      // We drop objection to allow the test to complete
      phase.drop_objection(this);
    endtask

endclass
  
