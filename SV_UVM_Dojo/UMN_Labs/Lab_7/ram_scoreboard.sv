`uvm_analysis_imp_decl(_mon_trans)
`uvm_analysis_imp_decl(_drv_trans)

class ram_scoreboard extends uvm_scoreboard;
    
    // register the scoreboard in the UVM factory
    `uvm_component_utils(ram_scoreboard);

    ram_transaction trans, input_trans;

    // analysis implementation ports
    uvm_analysis_imp_mon_trans #(ram_transaction,ram_scoreboard) Mon2Sb_port;
    uvm_analysis_imp_drv_trans #(ram_transaction,ram_scoreboard) Drv2Sb_port;

    // TLM FIFOs to store the actual and expected transaction values
    uvm_tlm_fifo #(ram_transaction)  drv_wr_fifo;
    uvm_tlm_fifo #(ram_transaction)  drv_rd_fifo;
    uvm_tlm_fifo #(ram_transaction)  mon_wr_fifo;
    uvm_tlm_fifo #(ram_transaction)  mon_rd_fifo;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //Instantiate the analysis ports and Fifo
      Mon2Sb_port = new("Mon2Sb",  this);
      Drv2Sb_port = new("Drv2Sb",  this);
      drv_wr_fifo     = new("drv_wr_fifo", this,8);
      drv_rd_fifo     = new("drv_rd_fifo", this,8);
      mon_wr_fifo     = new("mon_wr_fifo", this,8);
      mon_rd_fifo     = new("mon_rd_fifo", this,8);
   endfunction : build_phase

   // write_drv_trans will be called when the driver broadcasts a transaction
   // to the scoreboard
   function void write_drv_trans (ram_transaction input_trans);
       
      //uvm_report_info(get_full_name(),"Received Driver packet in scoreboard", UVM_LOW);

      // Try putting the write values in the EXPFIFO
      if(input_trans.wr_req == 1)
      begin
        void'(drv_wr_fifo.try_put(input_trans));
      end

       // Try putting the read values in the EXPFIFO
      if(input_trans.rd_req == 1)
      begin
        void'(drv_rd_fifo.try_put(input_trans));
      end

   endfunction : write_drv_trans

   // write_mon_trans will be called when the monitor broadcasts the DUT results
   // to the scoreboard 
   function void write_mon_trans (ram_transaction trans);

      //uvm_report_info(get_full_name(),"Received Monitor packet in scoreboard", UVM_LOW);

      // Try putting the write values in the EXPFIFO
      if(trans.wr_req == 1)
      begin
        void'(mon_wr_fifo.try_put(trans));
      end

       // Try putting the read values in the EXPFIFO
      if(trans.rd_req == 1)
      begin
        void'(mon_rd_fifo.try_put(trans));
      end
	
   endfunction : write_mon_trans

   task run_phase(uvm_phase phase);
      ram_transaction exp_trans, out_trans;
      forever begin
        // use get method of tlm_fifo to obtain the predicted/expected
        // output
        `uvm_info("Scoreboard run task", "WAITING for expected output",UVM_HIGH)
        drv_wr_fifo.get(exp_trans);

        // use get method of tlm_fifo to obtain the actual DUT
        // output
        `uvm_info("Scoreboard run task", "WAITING for actual output",UVM_HIGH)
        mon_rd_fifo.get(out_trans);

        //comapre that expected value with the actual DUT value of the counter
        if (exp_trans.data == out_trans.data) begin
          `uvm_info ("PASS ", $sformatf("Actual=%h Expected=%h \n",
          out_trans.data, exp_trans.data), UVM_LOW)
        end
        else begin
          `uvm_error("ERROR", $sformatf("Actual=%d Expected=%d \n",
          out_trans.data, exp_trans.data))
        end
      end
   endtask
endclass : ram_scoreboard
