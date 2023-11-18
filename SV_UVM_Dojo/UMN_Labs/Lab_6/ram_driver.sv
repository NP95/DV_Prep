class ram_driver extends uvm_driver #(ram_transaction);

  `uvm_component_utils(ram_driver)

  virtual ram_interface ram_vif;

  // Analysis port to broadcast input values to scoreboard

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    // Get interface reference from config database
    if(!uvm_config_db#(virtual ram_interface)::get(this, "", "ram_vif", ram_vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
  
    //Instantiate analysis port

  endfunction 

  task run_phase(uvm_phase phase);

    
    // Now drive normal traffic
    forever begin
      seq_item_port.get_next_item(req);
 
      // Wiggle pins of DUT
      @(ram_vif.driver_if_mp.driver_cb)
      begin 
        ram_vif.driver_if_mp.driver_cb.address <= req.address;
        if(req.wr_req)
        begin
          ram_vif.driver_if_mp.driver_cb.wr_req <= 1'b1;
          ram_vif.driver_if_mp.driver_cb.rd_req <= 1'b0;
          ram_vif.driver_if_mp.driver_cb.data <= req.data;
        end
        if(req.rd_req)
        begin
          ram_vif.driver_if_mp.driver_cb.wr_req <= 1'b0;
          ram_vif.driver_if_mp.driver_cb.rd_req <= 1'b1;
          ram_vif.driver_if_mp.driver_cb.data <= 16'bz;
        end
      end

      @(ram_vif.driver_if_mp.driver_cb)
      begin
        if(req.wr_req)
        begin
          ram_vif.driver_if_mp.driver_cb.wr_req <= 1'b0;
        end
        if(req.rd_req)
        begin
          ram_vif.driver_if_mp.driver_cb.rd_req <= 1'b0;
        end
      end

      // call the write method of implementation port in scoreboard to
      // broadcast input values


      seq_item_port.item_done();
    end
  endtask

endclass: ram_driver

