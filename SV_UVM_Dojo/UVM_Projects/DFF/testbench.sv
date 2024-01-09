

`include "uvm_macros.svh"
import uvm_pkg;


//////////////// Defining Sequence //////////////

class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)

	rand bit [3:0] a;
	rand bit [3:0] b;
//We declare y not as rand because y is not the stimulus to the DUT
	     bit [3:0] y;

	     //Every UVM object must have a constructor new
	     function new(input string path ="transaction");
		     super.new(path);
	     endfunction
endclass


//////////////// Defining Sequence //////////////


///////////////////////////////Constructing a Sequencer///////////////////////

class adder_sequencer extends uvm_sequence#(transaction);
	`uvm_object_utils(adder_sequencer)

	transaction adder_stimulus;

	function new(input string path = "sequencer");
		super.new(path);
	endfunction


/////The purpose of the body subroutine is to generate transactions
	virtual task body();
		repeat(30)
		begin
			adder_stimulus = transaction::type_id::create("adder_stimulus");
			start_item(adder_stimulus)
			if(adder_stimulus.randomize())
				`uvm_info("SEQ".$sformatf("a : %0d  b : %0d  y : %0d", tr.a, tr.b, tr.y), UVM_NONE);
			else
				`uvm_error("Failed to generate a stimulus");
			finish_item(adder_stimulus);
		end
	endtask
endclass



///////////////////////Writing a Driver from the Sequencer
//

class adder_driver extends uvm_driver#(adder_stimulus);
	`uvm_component_utils(driver)

	transaction adder_stimulus;
	virtual adder_if adder_if;

	function new(input string path = "adder_driver", uvm_component_parent = null);
		super.new(path,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		//Calling the build constructor of the parent class and
		//getting the adder interface registered in the factory.
		//assumption the set to the factory is in the top
		super.build_phase(phase);
		if(!uvm_config_db#(virtual adder_if)::get(this,"","aif",aif) // Path will be uvm_test_top.env.agent.adder_driver.aif
			`uvm_error("Adder_Driver","Unable to access the interface");
	endfunction

	virtual task run_phase(uvm_phase phase);
		adder_stimuls = transaction::type_id::create("adder_stimulus");

		forever begin
			seq_item_port.get_next_item(adder_stimulus);
			aif.a <= adder_stimulus.a;
			aif.b <= adder_stimulus.b;
			`uvm_info("AdderDriver",$sformatf("A : %0d B: %0d Y: %0d",adder_stimulus.a,adder_stimulus.b,adder_stimulus.y),UVM_NONE);
			seq_item_port.item_done();
			#20;
		end
        endtask

endclass



/////////////////Writing a Monitor
//
//
//

class adder_monitor extends uvm_monitor;
	`uvm_component_utils(adder_monitor)

	uvm_analysis_port#(transaction) send;
	transaction adder_stimulus;
	virtual adder_if adder_if;

	function new(input string inst="adder_monitor",uvm_component parent = null);
		super.new(inst,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
           super.build_phase(phase);
	   adder_stimulus = transaction::type_id::create("adder_stimulus");
	   send = new("send",this);
	   if(!uvm_config_db#(virtual adder_if)::get(this,"","aif",aif) // Path will be uvm_test_top.env.agent.adder_driver.aif
			`uvm_error("Adder_Monitor","Unable to access the interface");
   endfunction


   virtual task run_phase(uvm_phase phase)
	   forever begin
		   #20 
		   adder_stimulus.a = aif.a;
		   adder_stimulus.b = aif.b;
		   adder_stimulus.y = aif.y;
			`uvm_info("AdderMonitor",$sformatf("A : %0d B: %0d Y: %0d",adder_stimulus.a,adder_stimulus.b,adder_stimulus.y),UVM_NONE);
			send.write(adder_stimulus);
		end
	endtask

endclass

//////////////////////////////////////
//
// Writing a Scoreboard

class adder_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(adder_scoreboard)

	uvm_analyis_imp#(transaction,adder_scoreboard) receiver;

	function new(input string inst="adder_scoreboard",uvm_component parent=null);
		super.new(inst,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		receiver = new("receiver",this);
	endfunction

	virtual function void write(transaction tr);
		if(tr.y = (tr.a + tr.b))
			`uvm_info()
		else
			`uvm_info()

		$display("-------------------------------------------------------");
	endfunction
endclass


//////////////////////////////
// Writing Agent 
//

class adder_agent extends uvm_agent;
	`uvm_component_utils(agent)

	function new(input string inst = "adder_agent",uvm_component parent = null));
		super.new(inst,parent);
	endfunction

	adder_driver drv;
	adder_monitor mon;
	uvm_sequencer#(transaction) seqr;

	virtual function build_phase(uvm_phase phase);
		super.build(phase);
		drv = adder_driver::type_id::create("drv",this);
		mon = adder_mon::type_id::create("mon",this);
