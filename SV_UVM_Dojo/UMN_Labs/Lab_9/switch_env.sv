class switch_env extends uvm_env;
  `uvm_component_utils(switch_env)
    
  switch_scoreboard sb;

  //Agents defination
  switch_agent_input input_agent;
  switch_agent_output output_agent[4];

  //Virtual interface defination
  virtual switch_output_interface switch_vif[4];

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
    
  function void build_phase(uvm_phase phase);
    //Input agent instantiation
    input_agent = switch_agent_input::type_id::create("input_agent", this);
    input_agent.is_active = UVM_ACTIVE;

    //Output agents instantiation
    for(int i =0; i < 4; i++) begin
      string out_agent_name = $sformatf("output_agent_%0d",i);
      output_agent[i] = switch_agent_output::type_id::create(out_agent_name, this);

      //Output interface from the configuration database
      if(!uvm_config_db#(virtual switch_output_interface)::get(this, "", $sformatf("switch_output_vif_%0d",i), switch_vif[i])) begin
        `uvm_error("", "uvm_config_db::get failed")
      end

      //Setting configuration database based on the output agent 
      uvm_config_db#(virtual switch_output_interface)::set(null, $sformatf("uvm_test_top.env.%0s.mon",out_agent_name), "switch_vif", switch_vif[i]);
    end
    sb = switch_scoreboard::type_id::create("sb",this);
  endfunction
  
  //Connect ports of various TB components here
  function void connect_phase(uvm_phase phase);
    `uvm_info("", "Called env::connect_phase", UVM_NONE);

    //Driver's analysis port to scoreboard connection
    input_agent.mon.Mon2Sb_port_input.connect(sb.Drv2Sb_port);
      
    //Monitor's analysis port to scoreboard connection
    for(int i =0; i < 4; i++) begin
      output_agent[i].mon.Mon2Sb_port_output.connect(sb.Mon2Sb_port);
    end

  endfunction: connect_phase


endclass
