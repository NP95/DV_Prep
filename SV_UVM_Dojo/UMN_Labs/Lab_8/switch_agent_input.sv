class switch_agent_input extends uvm_agent;
  `uvm_component_utils(switch_agent_input)
    
    //Define the driver, monitor and sequencer
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);

	    //Instantiate the driver, monitor and sequencer

    endfunction    
    
    function void connect_phase(uvm_phase phase);

    	// connect the sequencer to the driver.

    endfunction      

endclass
