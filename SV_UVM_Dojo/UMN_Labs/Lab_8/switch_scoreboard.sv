`uvm_analysis_imp_decl(_mon_trans)
`uvm_analysis_imp_decl(_drv_trans)

class switch_scoreboard extends uvm_scoreboard;
    
    // register the scoreboard in the UVM factory
    `uvm_component_utils(switch_scoreboard);

    switch_transaction trans, input_trans;

    // analysis implementation ports
    uvm_analysis_imp_mon_trans #(switch_transaction,switch_scoreboard) Mon2Sb_port;
    uvm_analysis_imp_drv_trans #(switch_transaction,switch_scoreboard) Drv2Sb_port;

    // TLM FIFOs to store the actual and expected transaction values
    uvm_tlm_fifo #(switch_transaction)  drv_fifo;
    uvm_tlm_fifo #(switch_transaction)  mon_fifo;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //Instantiate the analysis ports and Fifo
      Mon2Sb_port = new("Mon2Sb",  this);
      Drv2Sb_port = new("Drv2Sb",  this);
      drv_fifo     = new("drv_fifo", this,8);
      mon_fifo     = new("mon_fifo", this,8);

   endfunction : build_phase


   // write_drv_trans will be called when the driver broadcasts a transaction
   // to the scoreboard
   function void write_drv_trans (switch_transaction input_trans);
       
      //uvm_report_info(get_full_name(),$sformatf("Received Driver packet in scoreboard %d",input_trans.data_in), UVM_LOW);

      // Try putting the driver trans in the EXPFIFO
      void'(drv_fifo.try_put(input_trans));

   endfunction : write_drv_trans

   // write_mon_trans will be called when the monitor broadcasts the DUT results
   // to the scoreboard 
   function void write_mon_trans (switch_transaction trans);

      //uvm_report_info(get_full_name(),"Received Monitor packet in scoreboard", UVM_LOW);

      // Try putting the monitor trans in the EXPFIFO
      void'(mon_fifo.try_put(trans));

   endfunction : write_mon_trans

   task run_phase(uvm_phase phase);
      switch_transaction exp_trans, out_trans;
      forever begin
        // use get method of tlm_fifo to obtain the predicted/expected
        // output
        //`uvm_info("Scoreboard run task", "WAITING for expected output",UVM_HIGH)
        drv_fifo.get(exp_trans);

        // use get method of tlm_fifo to obtain the actual DUT
        // output
        //`uvm_info("Scoreboard run task", "WAITING for actual output",UVM_HIGH)
        mon_fifo.get(out_trans);

        //compare that expected value with the actual DUT value of the counter
        if((exp_trans.port_num == out_trans.port_num) && (exp_trans.data_in == out_trans.data_out))
        begin
           `uvm_info("PASS", $sformatf("Actual=%d Expected=%d \n",
            out_trans.data_out, exp_trans.data_in),UVM_LOW)
        end
        else
        begin
           `uvm_error("ERROR", $sformatf("Actual=%d Expected=%d \n",
            out_trans.data_out, exp_trans.data_in))
        end
      end
   endtask
endclass : switch_scoreboard
