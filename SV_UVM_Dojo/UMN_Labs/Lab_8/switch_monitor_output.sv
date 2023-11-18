class switch_monitor_output extends uvm_monitor;
     // register the monitor in the UVM factory
     `uvm_component_utils(switch_monitor_output)

     //Declare virtual interface

     // Analysis port to broadcast results to scoreboard 
     uvm_analysis_port #(switch_transaction) Mon2Sb_port_output; 
     
     function new(string name, uvm_component parent);
       super.new(name, parent);
     endfunction
     
     function void build_phase(uvm_phase phase);

       // Get interface reference from config database

       Mon2Sb_port_output = new("Mon2Sb_output",this);
     endfunction 

     task run_phase(uvm_phase phase);


           //Broadcast the packet from DUT to scoreboard

     endtask : run_phase

endclass : switch_monitor_output
