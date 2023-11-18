class switch_agent_output extends uvm_agent;
  `uvm_component_utils(switch_agent_output)
    
    //Define the monitor
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    string monitor_name;

    function void build_phase(uvm_phase phase);

    //Instantiate the monitor

    endfunction    
    
    function void connect_phase(uvm_phase phase);
    endfunction      

endclass


