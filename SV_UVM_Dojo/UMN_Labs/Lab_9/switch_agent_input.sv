class switch_agent_input extends uvm_agent;
  `uvm_component_utils(switch_agent_input)
    
    //Driver, monitor and sequenceri defination
    switch_driver driver;
    uvm_sequencer#(switch_transaction) sequencer;
    switch_monitor_input mon;

    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      //Driver, monitor and sequencer instantiation
      driver = switch_driver::type_id::create("driver", this);
      sequencer = uvm_sequencer#(switch_transaction)::type_id::create("sequencer", this);
      mon = switch_monitor_input::type_id::create("mon",this);

    endfunction    
    
    function void connect_phase(uvm_phase phase);
      //Sequencer and driver connection.
      driver.seq_item_port.connect(sequencer.seq_item_export);

    endfunction      

endclass
