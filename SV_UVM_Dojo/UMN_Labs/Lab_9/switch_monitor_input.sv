class switch_monitor_input extends uvm_monitor;
  // register the monitor in the UVM factory
  `uvm_component_utils(switch_monitor_input)

  //Virtual interface declaration
  virtual switch_input_interface switch_vif;

  // Analysis port to broadcast results to scoreboard 
  uvm_analysis_port #(switch_transaction) Mon2Sb_port_input; 
     
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
     
  function void build_phase(uvm_phase phase);
    //Interface reference from config database
    if(!uvm_config_db#(virtual switch_input_interface)::get(this, "", "switch_input_vif", switch_vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
    Mon2Sb_port_input = new("Mon2Sb_input",this);
  endfunction 

  task run_phase(uvm_phase phase);
    //Send the packet driven to DUT to scoreboard
    switch_transaction trans;
    trans = new ("trans");
    fork
      forever begin
        @(switch_vif.monitor_if_mp.monitor_cb)
        begin
          if(switch_vif.monitor_if_mp.monitor_cb.ready_in)
          begin
            trans.data_in = switch_vif.monitor_if_mp.monitor_cb.data_in;
            Mon2Sb_port_input.write(trans);
          end
        end
      end
    join
  endtask : run_phase

endclass
