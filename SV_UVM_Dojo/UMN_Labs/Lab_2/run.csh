vcs -Mupdate +v2k -sverilog -timescale=1ns/10ps +incdir+$UVM_HOME/src $UVM_HOME/src/uvm.sv $UVM_HOME/src/dpi/uvm_dpi.cc -CFLAGS -DVCS top.sv -l compile.log +vcs+dumpvars+verilog.vpd -debug_all

./simv +UVM_TESTNAME=uvm_test_1 
