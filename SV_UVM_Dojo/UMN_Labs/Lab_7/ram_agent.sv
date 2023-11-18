class ram_agent extends uvm_agent;
  `uvm_component_utils(ram_agent)
    
    ram_driver driver;
    uvm_sequencer#(ram_transaction) sequencer;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      driver = ram_driver::type_id::create("driver", this);
      sequencer =
      uvm_sequencer#(ram_transaction)::type_id::create("sequencer", this);
    endfunction    
    
    // In UVM connect phase, we connect the sequencer to the driver.
    function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction      

endclass
