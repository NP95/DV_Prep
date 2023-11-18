package ram_testbench_pkg;
  import uvm_pkg::*;
  
  `include "ram_sequence.sv"
  `include "ram_driver.sv"
  `include "ram_driver_new.sv"
  `include "ram_monitor.sv"
  `include "ram_monitor_new.sv"
  `include "ram_scoreboard.sv"

  //Include subscriber to package

  `include "ram_agent.sv"
  `include "ram_env.sv"
  `include "ram_test.sv"

endpackage
  
