//Module TOP

`include "uvm_macros.svh"
`include "adder_testbench_pkg.sv"

module top;

  //Import uvm and adder package

  

  // Instantiate the interface

  
  // Instantiate the DUT and connect it to the interface


  
  initial begin
    
    // Place the interface into the UVM configuration database
    
    // Call run_test

  end
  
  initial
  begin

    //Complete the monitor statement
    $monitor("a - %d b - %d sum - %d carry - %d",);
  end
  
  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end
  
endmodule

