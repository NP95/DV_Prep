`include "adder_testbench_pkg.sv"
//Top module
module adder_tb_top; 
    
  //Instantiate adder interface
  adder_interface a_int();
      
  //Instantiate adder DUT
  adder ad0 (a_int.dut);

  //Instantiate adder TB Environment 
  adder_env tb0 (a_int.tb);

  //To dump waves
  initial
  begin
    $vcdpluson();
  end
  
endmodule 
