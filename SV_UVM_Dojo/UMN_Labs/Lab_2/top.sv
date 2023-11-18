`include "uvm_macros.svh"
`include "phases_testbench_pkg.sv"

module top;
  import uvm_pkg::*;
  import phases_testbench_pkg::*;
  
  string testname;

  initial 
  begin
    //Pass the test name as argument to run_test
    run_test();
  end

  initial
  begin
    if($value$plusargs("UVM_TESTNAME=%s",testname))
    begin
      $display("Passed testname through command line argument\n");
    end
    else
    begin
      $display("Passed testname as an argument to run_test \n");
    end
  end
    
endmodule
