class switch_monitor_input extends uvm_monitor;
     // register the monitor in the UVM factory
     `uvm_component_utils(switch_monitor_input)

     //Declare virtual interface

     // Analysis port to broadcast results to scoreboard 
     uvm_analysis_port #(switch_transaction) Mon2Sb_port_input; 
     
     function new(string name, uvm_component parent);
       super.new(name, parent);
     endfunction
     
     function void build_phase(uvm_phase phase);

       // Get interface reference from config database

       Mon2Sb_port_input = new("Mon2Sb_input",this);
     endfunction 

     task run_phase(uvm_phase phase);

         //Send the packet driven to DUT to scoreboard

     endtask : run_phase
endclass
