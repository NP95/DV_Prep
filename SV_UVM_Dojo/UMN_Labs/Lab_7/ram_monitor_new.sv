class ram_monitor_new extends ram_monitor;
     // register the monitor in the UVM factory
     `uvm_component_utils(ram_monitor_new)

     function new(string name, uvm_component parent);
       super.new(name, parent);
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
	            read_trans.wr_req = ram_vif.monitor_if_mp.monitor_cb.wr_req;
	            read_trans.rd_req = 1'b1;
	            Mon2Sb_port.write(read_trans);
                    aport.write(read_trans);
	          end
	          if(ram_vif.monitor_if_mp.monitor_cb.wr_req)
	          begin
	            write_trans.address = ram_vif.monitor_if_mp.monitor_cb.address;
	            write_trans.data = ram_vif.monitor_if_mp.monitor_cb.data;
	            write_trans.wr_req = ram_vif.monitor_if_mp.monitor_cb.wr_req;
	            write_trans.rd_req = ram_vif.monitor_if_mp.monitor_cb.rd_req;
	            Mon2Sb_port.write(write_trans);
                    aport.write(write_trans);
	          end
	     end
	   end
	 join
     endtask : run_phase

endclass : ram_monitor_new
