`include "uvm_macros.svh"
`include "switch_testbench_pkg.sv"

module top;
  import uvm_pkg::*;
  import switch_testbench_pkg::*;

  bit clk;
  
  //clock generation
  always #5 clk = ~clk;
  
  initial 
  begin
    clk = 0;
  end

  // Instantiate the interfaces

  switch sw0(.clk(clk),
	.reset(switch_input_if.reset),
	.ready_in(switch_input_if.ready_in),
	.data_in(switch_input_if.data_in),
	.port_num(switch_input_if.port_num),
	.ready_out_0(switch_output_if[0].ready_out),
	.ready_out_1(switch_output_if[1].ready_out),
	.ready_out_2(switch_output_if[2].ready_out),
	.ready_out_3(switch_output_if[3].ready_out),
	.data_out_0(switch_output_if[0].data_out),
	.data_out_1(switch_output_if[1].data_out),
	.data_out_2(switch_output_if[2].data_out),
	.data_out_3(switch_output_if[3].data_out));

  //Use generate block to send output interface into configuration database 

  initial begin

    // Place the input interface into the UVM configuration database


    // Start the test
    run_test();
  end

  initial begin
    $vcdpluson();
  end

endmodule

