class switch_driver extends uvm_driver #(switch_transaction);

  `uvm_component_utils(switch_driver)

  //Define the virtual interface

  // Analysis port to broadcast input values to scoreboard
  uvm_analysis_port #(switch_transaction) Drv2Sb_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);

    // Get interface reference from config database

    Drv2Sb_port = new("Drv2Sb",this);
  endfunction 

  task run_phase(uvm_phase phase);

    int seq_1 = 0;
    int seq_2 = 0;
    int seq_3 = 0;
    int seq_4 = 0;
    
    // Now drive normal traffic
    forever begin

      //Get the next item from sequencer
 
      // Wiggle pins of DUT
 
    end
  endtask

endclass: switch_driver

