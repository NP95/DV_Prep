

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
	endfunction

	virtual task run_phase(uvm_phase phase);
        endtask

endclass



/////////////////Writing a Monitor
//
//
//

class adder_monitor extends uvm_monitor;
	`uvm_component_utils(adder_monitor)

	uvm_analysis_ports#(transaction) send;
	transaction adder_stimulus;
	virtual adder_if adder_if;

	function new(input string inst="adder_monitor",uvm_component parent = null);
		super.new(inst,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
           super.build_phase(phase);
	   adder_stimulus = transaction::type_id::create("adder_stimulus");
