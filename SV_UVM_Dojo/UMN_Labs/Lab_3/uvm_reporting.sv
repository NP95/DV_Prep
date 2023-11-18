class uvm_reporting extends uvm_component; 

  `uvm_component_utils(uvm_reporting)
  
  function new(string name,uvm_component parent); 
    super.new(name, parent); 
  endfunction 

  function void start_of_simulation_phase(uvm_phase phase);
    //set_report_severity_action(UVM_FATAL,UVM_DISPLAY);
  endfunction
  
  task run_phase(uvm_phase phase);
    
    uvm_report_info(get_full_name(), 
      "Info Message : Verbo level - UVM_NONE",UVM_NONE); 

    uvm_report_info(get_full_name(), 
      "Info Message : Verbo level - UVM_LOW ",UVM_LOW); 

    uvm_report_info(get_full_name(), 
      "Info Message : Verbo level - 150 ",150); 

    uvm_report_info(get_full_name(), 
      "Info Message : Verbo level - UVM_MEDIUM",UVM_MEDIUM); 
    
    uvm_report_info(get_full_name(), 
      "Info Message : Verbo level - UVM_HIGH",UVM_HIGH);
    
    uvm_report_info(get_full_name(), 
      "Info Message : Verbo level - UVM_FULL",UVM_FULL);
    
    uvm_report_info(get_full_name(), 
      "Info Message : Verbo level - UVM_DEBUG",UVM_DEBUG);

    uvm_report_warning(get_full_name(), 
      "Warning Messgae from uvm_reporting",UVM_LOW); 

    uvm_report_error(get_full_name(), 
      "Error Message from uvm_reporting",UVM_LOW);
    
    uvm_report_fatal(get_full_name(),
        "Fatal Message from uvm_reporting",UVM_LOW);

    uvm_report_info(get_full_name(), 
      "Info Message : Message after fatal error",UVM_LOW);


  endtask
  
endclass
