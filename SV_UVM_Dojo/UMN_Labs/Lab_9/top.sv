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

  //Interfaces instantiation
  switch_input_interface switch_input_if(clk);
  switch_output_interface switch_output_if[3:0](clk);

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

  //Generate block sends output interface into configuration database 
  generate
    genvar i;
    for(i =0; i < 4; i =i+1) begin
      initial
      begin
        uvm_config_db#(virtual switch_output_interface)::set(null, "*", $sformatf("switch_output_vif_%0d",i), switch_output_if[i]);
      end
    end
  endgenerate

  initial begin
    //Input interface into the UVM configuration database
    uvm_config_db#(virtual switch_input_interface)::set(null, "*", "switch_input_vif", switch_input_if);

    //Starting test
    run_test();
  end

  initial begin
    $vcdpluson();
  end

  //Instantiate Assertion Module
 

endmodule

