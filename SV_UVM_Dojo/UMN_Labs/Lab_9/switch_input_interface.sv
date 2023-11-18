interface switch_input_interface(input clk);

  //Input interface signals
  logic reset;
  logic ready_in;
  logic [7:0] data_in;
  logic [1:0] port_num;

  //Driver clocking block
  clocking driver_cb @ (negedge clk);
    output reset;
    output ready_in;
    output data_in;
    output port_num;
  endclocking : driver_cb

  //Driver modport
  modport driver_if_mp (clocking driver_cb);

  //Monitor clocking block 
  clocking monitor_cb @ (negedge clk);
    input reset;
    input ready_in;
    input data_in;
    input port_num;
  endclocking : monitor_cb

  //Monitor modport
  modport monitor_if_mp (clocking monitor_cb);


endinterface

