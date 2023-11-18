class ram_env extends uvm_env;
  `uvm_component_utils(ram_env)
    
    ram_agent agent;
    ram_monitor mon;
    ram_scoreboard sb;

    //Declare subscriber object here

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      agent = ram_agent::type_id::create("agent", this);
      mon   = ram_monitor::type_id::create("mon",this);
      sb    = ram_scoreboard::type_id::create("sb",this);

      //Instantiate subscriber object 

    endfunction
  
    // connect ports of various TB components here
   function void connect_phase(uvm_phase phase);
      `uvm_info("", "Called env::connect_phase", UVM_NONE);
      
      // connect driver's analysis port to scoreboard's analysis
      // implementation por
      agent.driver.Drv2Sb_port.connect(sb.Drv2Sb_port);
      
      // connect monitor's analysis port to scoreboard's analysis
      // implementation port
      mon.Mon2Sb_port.connect(sb.Mon2Sb_port);

      // connect monitor's analysis port to subscriber's analysis
      // implementation port

   endfunction: connect_phase


endclass
