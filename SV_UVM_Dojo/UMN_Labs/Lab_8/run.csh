vcs -cm line+cond+fsm -Mupdate +v2k -sverilog -timescale=1ns/10ps +incdir+$UVM_HOME/src $UVM_HOME/src/uvm.sv $UVM_HOME/src/dpi/uvm_dpi.cc -CFLAGS -DVCS top.sv switch_input_interface.sv switch_output_interface.sv switch.v -l compile.log -debug_all +vcs+dumpvars+verilog.vpd

./simv -cm line+cond+fsm +UVM_TESTNAME=switch_test +ntb_random_seed=5258627 +UVM_VERBOSITY=UVM_HIGH

