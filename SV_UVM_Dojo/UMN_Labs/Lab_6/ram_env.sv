class ram_env extends uvm_env;
  `uvm_component_utils(ram_env)
    
    //Declare all components of environment

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      //Instantiate the components

    endfunction
  
    // connect ports of various TB components here
   function void connect_phase(uvm_phase phase);
      `uvm_info("", "Called env::connect_phase", UVM_NONE);
      
      // connect driver's analysis port to scoreboard's analysis
      // implementation port
      
      // connect monitor's analysis port to scoreboard's analysis
      // implementation port


   endfunction: connect_phase


endclass
