FILES = Packet.sv
VCS_FLAGS = -sverilog +plusarg_save -timescale=1ns/1ns 
UVM_FLAGS = +incdir+${UVM_HOME}/src ${UVM_HOME}/src/uvm_pkg.sv

vcs:	simv
	simv +UVM_TESTNAME=test1 -l simv.log

simv:   ${FILES} 
	@if [ ! -e ${UVM_HOME}/src/uvm_pkg.sv ];then \
	 echo "*******************************************************";\
         echo "Environemnt varible UVM_HOME is not set or points to incorrect path"; \
	 echo "*******************************************************";\
	 fi 
	vcs ${UVM_FLAGS} ${VCS_FLAGS} ${FILES} -l comp.log 

questa: ${FILES} 
	@if [ ! -e ${UVM_HOME}/src/uvm_pkg.sv ];then \
	 echo "*******************************************************";\
         echo "Environemnt varible UVM_HOME is not set or points to incorrect path"; \
	 echo "*******************************************************";\
	 fi 
	qverilog ${UVM_FLAGS}  +incdir+. ${FILES} -R +UVM_TESTNAME=test1

ius: ${FILES} 
	@if [ ! -e ${UVM_HOME}/src/uvm_pkg.sv ];then \
	 echo "*******************************************************";\
         echo "Environemnt varible UVM_HOME is not set or points to incorrect path"; \
	 echo "*******************************************************";\
	 fi 
	irun ${UVM_FLAGS} +incdir+. ${FILES} +UVM_TESTNAME=test1

waves:	simv_dbg
	simv_dbg +UVM_TESTNAME=test1 -l simv_dbg.log  -gui

simv_dbg: ${FILES} 
	vcs ${FLAGS} ${FILES} -l comp_dbg.log -debug_all -o simv_dbg -Mdir=csrc_dbg

DIR = $(shell basename `pwd`)

tar:	clean
	cd ..; \
	tar cvf ${DIR}.tar ${DIR}

clean:
	@rm -rf simv* csrc* *.log *.key core* .__solver* *.vpd *.vcd 
	@rm -rf *~ .__snps* *.bck .vcsmx_rebuild vc_hdrs.h DVEfiles
	@rm -rf work vsim.wlf INCA_libs 

