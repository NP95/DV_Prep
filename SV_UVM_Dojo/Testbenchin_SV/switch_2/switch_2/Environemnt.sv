////////////////////////////////////////////////
////s~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~s////
////s           www.testbench.in           s////
////s                                      s////
////s        SystemVerilog Tutorial        s////
////s           gopi@testbench.in          s////
////s~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~s////
////////////////////////////////////////////////
`ifndef GUARD_ENV
`define GUARD_ENV

class Environment ;

  virtual mem_interface.MEM    mem_intf      ;
  virtual input_interface.IP  input_intf     ;
  virtual output_interface.OP output_intf[4] ;

function new(virtual mem_interface.MEM    mem_intf_new       ,
             virtual input_interface.IP  input_intf_new     ,
             virtual output_interface.OP output_intf_new[4] );

  this.mem_intf      = mem_intf_new    ;
  this.input_intf    = input_intf_new  ;
  this.output_intf   = output_intf_new ;
  
  $display(" %0d : Environemnt : created env object",$time);
endfunction : new

function void build();
 $display(" %0d : Environemnt : start of build() method",$time);
 $display(" %0d : Environemnt : end of build() method",$time);
endfunction :build

task reset();
 $display(" %0d : Environemnt : start of reset() method",$time);
 $display(" %0d : Environemnt : end of reset() method",$time);
endtask : reset

task cfg_dut();
 $display(" %0d : Environemnt : start of cfg_dut() method",$time);
 $display(" %0d : Environemnt : end of cfg_dut() method",$time);
endtask : cfg_dut

task start();
 $display(" %0d : Environemnt : start of start() method",$time);
 $display(" %0d : Environemnt : end of start() method",$time);
endtask : start

task wait_for_end();
 $display(" %0d : Environemnt : start of wait_for_end() method",$time);
 $display(" %0d : Environemnt : end of wait_for_end() method",$time);
endtask : wait_for_end

task run();
 $display(" %0d : Environemnt : start of run() method",$time);
 build();
 reset();
 cfg_dut();
 start();
 wait_for_end();
 report();
 $display(" %0d : Environemnt : end of run() method",$time);
endtask : run

task report();
endtask : report

endclass

`endif
