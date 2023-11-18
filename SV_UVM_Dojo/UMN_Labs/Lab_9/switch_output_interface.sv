interface switch_output_interface(input clk);
  
  //Output interface signals
  logic ready_out;
  logic [7:0] data_out;

  //Define the clocking block
  clocking monitor_cb @ (negedge clk);
    input ready_out;
    input data_out;
  endclocking : monitor_cb

  //Define the modport
  modport monitor_if_mp (clocking monitor_cb);

endinterface
