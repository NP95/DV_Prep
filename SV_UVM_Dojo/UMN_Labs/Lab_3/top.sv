`include "uvm_macros.svh"
`include "reporting_testbench_pkg.sv"

module top;
  import uvm_pkg::*;
  import reporting_testbench_pkg::*;

  initial 
  begin
    run_test();
  end
    
endmodule
