class switch_agent_output extends uvm_agent;
  `uvm_component_utils(switch_agent_output)
    
    //Monitor definitation
    switch_monitor_output mon;   

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    string monitor_name;

    function void build_phase(uvm_phase phase);
      //Monitor instantiation
      mon = switch_monitor_output::type_id::create("mon",this);
    endfunction    
    
    function void connect_phase(uvm_phase phase);
    endfunction      

endclass


