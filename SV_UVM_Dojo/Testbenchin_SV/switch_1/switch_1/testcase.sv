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

initial
begin
$display(" ******************* Start of testcase ****************");

#1000;
end

final
$display(" ******************** End of testcase *****************");

endprogram 
`endif
