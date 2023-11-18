class uvm_cmpt_1 extends uvm_component; 

  `uvm_component_utils(uvm_cmpt_1)

  //uvm_cmpt_2 cmpt_2;
  
  function new(string name,uvm_component parent); 
    super.new(name, parent); 
  endfunction 
 
  function void build_phase(uvm_phase phase);
    //cmpt_2 = uvm_cmpt_2::type_id::create("cmpt_2", this);
    uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - build_phase",UVM_LOW); 
  endfunction
 
  function void connect_phase(uvm_phase phase);
    uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - connect_phase",UVM_LOW); 
  endfunction
 
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - end of elaboration phase",UVM_LOW); 
  endfunction
 
  function void start_of_simulation_phase(uvm_phase phase);
    uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - start_of_simulation phase",UVM_LOW); 
  endfunction

  /*
  	task pre_reset_phase(uvm_phase phase);
  	  phase.raise_objection(this);
  	     #1 uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - pre_reset phase",UVM_LOW); 
  	  phase.drop_objection(this);
  	endtask

  	task reset_phase(uvm_phase phase);
  	  phase.raise_objection(this);
  	     #1 uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - reset phase",UVM_LOW); 
  	  phase.drop_objection(this);
  	endtask

  	task post_reset_phase(uvm_phase phase);
  	  phase.raise_objection(this);
  	     #1 uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - post_reset phase",UVM_LOW); 
  	  phase.drop_objection(this);
  	endtask
  */

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
      uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - run phase",UVM_LOW); 
    phase.drop_objection(this);
  endtask
  
  function void extract_phase(uvm_phase phase);
    uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - extract phase",UVM_LOW); 
  endfunction
 
  function void check_phase(uvm_phase phase);
    uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - check phase",UVM_LOW); 
  endfunction
 
  function void report_phase(uvm_phase phase);
    uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - report phase",UVM_LOW); 
  endfunction
 
  function void final_phase(uvm_phase phase);
    uvm_report_info(get_full_name(), "Class uvm_cmpt_1 - final phase",UVM_LOW); 
  endfunction
 
endclass
