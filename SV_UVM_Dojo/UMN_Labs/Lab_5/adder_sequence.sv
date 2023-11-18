class adder_transaction extends uvm_sequence_item;

  //Declare a and b

  //Define constraints

  //Register a,b in factory

  //Define do_print method

  function new (string name = "");
    super.new(name);
  endfunction

endclass: adder_transaction

class adder_sequence extends uvm_sequence#(adder_transaction);

  `uvm_object_utils(adder_sequence)

  //adder_transaction req_1;
  //adder_transaction req_2;

  function new (string name = "");
    super.new(name);
  endfunction

  task body;

    //Create 8 new transactions using repeat

      //Call wait_for_grant
      wait_for_grant();

      //Randomize sequence

      //call print     

      //Send request to driver

      //Wait for transaction to be driven     


    //Uncomment the following lines for question 2
    //wait_for_grant();
    //req_1 = adder_transaction::type_id::create("req_1");
    //if (!req_1.randomize()) begin
    //  `uvm_error("MY_SEQUENCE", "Randomize failed.");
    //end
    //`uvm_info("req_1_print","Printing REQ_1",UVM_LOW);
    //req_1.print();
    //send_request(req_1); 
    //wait_for_item_done();

    //wait_for_grant();

    //$cast(req_2,req_1.clone());

    //Uncomment the following lines based on the steps described in question 3
    //req_2 = adder_transaction::type_id::create("req_2");
    //req_2.copy(req_1);
    //req_2.a = 8;

    //`uvm_info("req_2_print","Printing REQ_2",UVM_LOW);
    //req_2.print();
    //send_request(req_2); 
    //wait_for_item_done();
    

  endtask: body

endclass: adder_sequence

