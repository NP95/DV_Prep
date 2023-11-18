package adder_testbench_pkg;
  import uvm_pkg::*;
  
  // The UVM sequence, transaction item, and driver are in these files:
  `include "adder_sequence.sv"
  `include "adder_driver.sv"
  `include "adder_agent.sv" 
  `include "adder_env.sv"
  `include "adder_test.sv"
  
endpackage
