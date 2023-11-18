`include "uvm_macros.svh"
`include "adder_testbench_pkg.sv"

module top;
  import uvm_pkg::*;
  import adder_testbench_pkg::*;
  
  // Instantiate the interface
  adder_interface dut_if1();
  
  // Instantiate the DUT and connect it to the interface
  adder dut1(dut_if1);
  
  initial begin
    // Place the interface into the UVM configuration database
    uvm_config_db#(virtual adder_interface)::set(null, "*", "dut_vif", dut_if1);
    // Start the test
    run_test();
  end
  
  initial
  begin
    $monitor("a - %d b - %d sum - %d carry - %d\n",dut_if1.a,dut_if1.b,dut_if1.sum,dut_if1.c_out);
  end
  
  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end
  
endmodule

