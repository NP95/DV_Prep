//Declare uvm_analysis_imp_decl macros

class ram_scoreboard extends uvm_scoreboard;
    
    // register the scoreboard in the UVM factory

    //Declare objects for ram_transaction to get packets from driver and monitor

    // analysis implementation ports

    // TLM FIFOs to store the actual and expected transaction values

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      //Instantiate the analysis ports and Fifo

   endfunction : build_phase

   // write_drv_trans will be called when the driver broadcasts a transaction
   // to the scoreboard

   // write_mon_trans will be called when the monitor broadcasts the DUT results
   // to the scoreboard 

   task run_phase(uvm_phase phase);

      //Declare ram transactions to get expected and actual packets from the FIFOs

      //
      forever begin
        `uvm_info("Scoreboard run task", "WAITING for expected output",UVM_HIGH)

        //Get expected transaction from driver write FIFO

        `uvm_info("Scoreboard run task", "WAITING for actual output",UVM_HIGH)

        //Get actual transaction from monitor read FIFO

        //compare the expected value with the actual DUT value and display result

      end
   endtask
endclass : ram_scoreboard
