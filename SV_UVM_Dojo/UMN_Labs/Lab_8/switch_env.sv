class switch_env extends uvm_env;
  `uvm_component_utils(switch_env)
    
    switch_scoreboard sb;

    //Define the agents

    //Declare virtual interface

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);

      //Instantiate the input agent

      //Instantiate the output agents in a for loop
      //Get the output interface from the configuration database
      //Set it to configuration database based on the output agent 

      sb    = switch_scoreboard::type_id::create("sb",this);
    endfunction
  
    // connect ports of various TB components here
   function void connect_phase(uvm_phase phase);
      `uvm_info("", "Called env::connect_phase", UVM_NONE);
      
      // connect driver's analysis port to scoreboard's analysis
      // implementation por
      
      // connect monitor's analysis port to scoreboard's analysis
      // implementation port

   endfunction: connect_phase


endclass
