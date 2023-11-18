interface ram_interface(input clk);
  
  logic [7:0] address;
  wire logic [15:0] data;
  logic rd_req;
  logic wr_req;
  logic rd_valid;

  clocking driver_cb @ (negedge clk);
    output address;
    inout data;
    output rd_req;
    output #2 wr_req;
    input rd_valid; 
  endclocking : driver_cb

  modport driver_if_mp (clocking driver_cb);

  clocking monitor_cb @ (negedge clk);
    input address;
    input data;
    input rd_req;
    input wr_req;
    input rd_valid; 
  endclocking : monitor_cb

  modport monitor_if_mp (clocking monitor_cb);
  
endinterface
