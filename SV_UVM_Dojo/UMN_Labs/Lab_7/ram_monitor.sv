class ram_monitor extends uvm_monitor;
     // register the monitor in the UVM factory
     `uvm_component_utils(ram_monitor)

     //Declare virtual interface
     virtual ram_interface ram_vif;

     // Analysis port to broadcast results to scoreboard 
     uvm_analysis_port #(ram_transaction) Mon2Sb_port; 
     
     // Analysis port to broadcast results to subscriber 
     
     function new(string name, uvm_component parent);
       super.new(name, parent);
     endfunction
     
     function void build_phase(uvm_phase phase);
       // Get interface reference from config database
       if(!uvm_config_db#(virtual ram_interface)::get(this, "", "ram_vif", ram_vif)) begin
         `uvm_error("", "uvm_config_db::get failed")
       end
       Mon2Sb_port = new("Mon2Sb",this);

       //Instantiate analysis port to send transactions to subscriber

     endfunction

     task run_phase(uvm_phase phase);
         //uvm_report_info(get_full_name(),"Run", UVM_LOW);
         ram_transaction read_trans;
         ram_transaction write_trans;
         read_trans = new ("trans");
         write_trans = new ("trans");

	 fork
	   forever begin
	     @(ram_vif.monitor_if_mp.monitor_cb)
	     begin
	          if(ram_vif.monitor_if_mp.monitor_cb.rd_valid)
	          begin
	            read_trans.address = ram_vif.monitor_if_mp.monitor_cb.address;
	            read_trans.data = ram_vif.monitor_if_mp.monitor_cb.data;
	            read_trans.wr_req = ram_vif.monitor_if_mp.monitor_cb.wr_req;
	            read_trans.rd_req = 1'b1;
	            Mon2Sb_port.write(read_trans);

                    //Send read transaction to subscriber

	          end
	          if(ram_vif.monitor_if_mp.monitor_cb.wr_req)
	          begin
	            write_trans.address = ram_vif.monitor_if_mp.monitor_cb.address;
	            write_trans.data = ram_vif.monitor_if_mp.monitor_cb.data;
	            write_trans.wr_req = ram_vif.monitor_if_mp.monitor_cb.wr_req;
	            write_trans.rd_req = ram_vif.monitor_if_mp.monitor_cb.rd_req;
	            Mon2Sb_port.write(write_trans);

                    //Send write transaction to subscriber

	          end
	     end
	   end
	 join
     endtask : run_phase

endclass : ram_monitor
