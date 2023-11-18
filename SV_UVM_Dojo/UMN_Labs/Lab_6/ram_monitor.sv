class ram_monitor extends uvm_monitor;
     // register the monitor in the UVM factory

     //Declare virtual interface

     // Analysis port to broadcast results to scoreboard 
     
     function new(string name, uvm_component parent);
       super.new(name, parent);
     endfunction
     
     function void build_phase(uvm_phase phase);
       // Get interface reference from config database

       //Instantiate Monitor analysis port

     endfunction

     task run_phase(uvm_phase phase);

         //Declare and instantiate ram_transaction

         //Fork off a forever loop to monitor dut signals, pack and send it to scoreboard

     endtask : run_phase

endclass : ram_monitor
