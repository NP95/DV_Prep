class switch_driver extends uvm_driver #(switch_transaction);

  `uvm_component_utils(switch_driver)

  //Virtual interface defination
  virtual switch_input_interface switch_vif;

  //Analysis port to broadcast input values to scoreboard
  uvm_analysis_port #(switch_transaction) Drv2Sb_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    //Interface reference from config database
    if(!uvm_config_db#(virtual switch_input_interface)::get(this, "", "switch_input_vif", switch_vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
    Drv2Sb_port = new("Drv2Sb",this);
  endfunction 

  task run_phase(uvm_phase phase);

    int seq_1 = 0;
    int seq_2 = 0;
    int seq_3 = 0;
    int seq_4 = 0;
    
    // Now drive normal traffic
    forever
    begin
      //Get the next item from sequencer
      seq_item_port.try_next_item(req);
 
      //Wiggle pins of DUT
      if(req != null)
      begin
        //Wiggle pins of DUT
        @(switch_vif.driver_if_mp.driver_cb)
        begin
          switch_vif.driver_if_mp.driver_cb.ready_in <= 1'b1;
          switch_vif.driver_if_mp.driver_cb.data_in <= req.data_in;
          switch_vif.driver_if_mp.driver_cb.port_num <= req.port_num;
        end
        //Calculate the number of packets driven in each sequence
        case(req.port_num)
          2'b00 : begin
            seq_1++;
          end
          2'b01 : begin
            seq_2++;
          end
          2'b10 : begin
            seq_3++;
          end
          2'b11 : begin
            seq_4++;
          end
        endcase
        `uvm_info("DRIVER",$sformatf("seq_1=%0d seq_2=%0d  seq_3=%0d seq_4=%0d",seq_1,seq_2,seq_3,seq_4),UVM_HIGH);
        seq_item_port.item_done();
      end
      else
      begin
        //Reset the ready_in after driving packet
        @(switch_vif.driver_if_mp.driver_cb)
        begin
          switch_vif.driver_if_mp.driver_cb.ready_in <= 1'b0;
        end
      end
    end
  endtask

endclass: switch_driver

