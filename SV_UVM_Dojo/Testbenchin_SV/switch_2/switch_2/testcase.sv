////////////////////////////////////////////////
////s~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~s////
////s           www.testbench.in           s////
////s                                      s////
////s        SystemVerilog Tutorial        s////
////s           gopi@testbench.in          s////
////s~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~s////
////////////////////////////////////////////////
`ifndef GUARD_TESTCASE
`define GUARD_TESTCASE


program testcase(mem_interface.MEM mem_intf,input_interface.IP input_intf,output_interface.OP output_intf[4]);

Environment env;

initial
begin
$display(" ******************* Start of testcase ****************");
env = new(mem_intf,input_intf,output_intf);
env.run();
#1000;
end

final
$display(" ******************** End of testcase *****************");


endprogram 
`endif
