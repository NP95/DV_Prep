class adder_env extends uvm_env;
  `uvm_component_utils(adder_env)
  
  adder_agent agent;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    agent = adder_agent::type_id::create("agent", this);
  endfunction

endclass
