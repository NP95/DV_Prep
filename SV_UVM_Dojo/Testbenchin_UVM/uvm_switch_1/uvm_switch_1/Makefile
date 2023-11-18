FILES = rtl.sv top.sv interface.sv 
VCS_FLAGS = -sverilog +plusarg_save -timescale=1ns/1ns 
UVM_FLAGS = +incdir+${UVM_HOME}/src ${UVM_HOME}/src/uvm_pkg.sv

vcs:   ${FILES} 
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
	vlib work 
	vlog ${UVM_FLAGS} +incdir+.  ${FILES}

ius: ${FILES} 
	@if [ ! -e ${UVM_HOME}/src/uvm_pkg.sv ];then \
	 echo "*******************************************************";\
         echo "Environemnt varible UVM_HOME is not set or points to incorrect path"; \
	 echo "*******************************************************";\
	 fi 
	irun ${UVM_FLAGS} +incdir+.  ${FILES} 

waves:	simv_dbg
	simv_dbg -l simv_dbg.log  -gui

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

