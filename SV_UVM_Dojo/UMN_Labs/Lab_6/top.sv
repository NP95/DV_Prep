`include "uvm_macros.svh"
`include "ram_testbench_pkg.sv"

module top;
  import uvm_pkg::*;
  import ram_testbench_pkg::*;
  
  bit clk;
  
  //clock generation
  always #5 clk = ~clk;
  
  initial 
  begin
    clk = 0;
  end

  // Instantiate the interface
  ram_interface ram_if(clk);

  ram dut(.clk(clk),
          .address(ram_if.address),
          .data(ram_if.data),
          .rd_req(ram_if.rd_req),
          .wr_req(ram_if.wr_req),
          .rd_valid(ram_if.rd_valid));
  
  initial 
  begin
    
    // Place the interface into the UVM configuration database
    uvm_config_db#(virtual ram_interface)::set(null, "*", "ram_vif", ram_if);
    
    // Start the test
    run_test();
  end

  initial begin
    $vcdpluson();
  end

endmodule
