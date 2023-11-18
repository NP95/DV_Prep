class switch_transaction extends uvm_sequence_item;

  `uvm_object_utils(switch_transaction)
  
  //Transaction fields
  bit [1:0] port_num;
  rand bit [7:0] data_in;
  bit [7:0] data_out;

  function new (string name = "");
    super.new(name);
  endfunction

endclass: switch_transaction




class sequence_1 extends uvm_sequence#(switch_transaction);

  `uvm_object_utils(sequence_1)

  function new (string name = "");
    super.new(name);
  endfunction

  task body;    
    //Generate 8 transactions to port 0 
    repeat(8)
    begin
      req = switch_transaction::type_id::create("req");
      start_item(req);
      if (!req.randomize()) begin
        `uvm_error("SEQUENCE_1", "Randomize failed.");
      end
      req.port_num = 2'b00;
      finish_item(req);
    end
  endtask: body

endclass: sequence_1




class sequence_2 extends uvm_sequence#(switch_transaction);

  `uvm_object_utils(sequence_2)

  function new (string name = "");
    super.new(name);
  endfunction

  task body;
    //Generate 8 transactions to port 1 
    repeat(8)
    begin
      req = switch_transaction::type_id::create("req");
      start_item(req);
      if (!req.randomize()) begin
        `uvm_error("SEQUENCE_1", "Randomize failed.");
      end
      req.port_num = 2'b01;
      finish_item(req);
    end
  endtask: body

endclass: sequence_2




class sequence_3 extends uvm_sequence#(switch_transaction);

  `uvm_object_utils(sequence_3)

  function new (string name = "");
    super.new(name);
  endfunction

  task body;
    //Generate 8 transactions to port 2 
    repeat(8)
    begin
      req = switch_transaction::type_id::create("req");
      start_item(req);
      if (!req.randomize()) begin
        `uvm_error("SEQUENCE_1", "Randomize failed.");
      end
      req.port_num = 2'b10;
      finish_item(req);
    end
  endtask: body

endclass: sequence_3




class sequence_4 extends uvm_sequence#(switch_transaction);

  `uvm_object_utils(sequence_4)

  function new (string name = "");
    super.new(name);
  endfunction

  task body;
    //Generate 8 transactions to port 3 
    repeat(8)
    begin
      req = switch_transaction::type_id::create("req");
      start_item(req);
      if (!req.randomize()) begin
        `uvm_error("SEQUENCE_1", "Randomize failed.");
      end
      req.port_num = 2'b11;
      finish_item(req);
    end
  endtask: body

endclass: sequence_4




class main_sequence extends uvm_sequence#(switch_transaction);

  `uvm_object_utils(main_sequence)

  //Declare the four sequences
  sequence_1 seq_1;
  sequence_2 seq_2;
  sequence_3 seq_3;
  sequence_4 seq_4;

  function new (string name = "");
    super.new(name);

    //Sequences instantiation
    seq_1 = sequence_1::type_id::create("seq_1");
    seq_2 = sequence_2::type_id::create("seq_2");
    seq_3 = sequence_3::type_id::create("seq_3");
    seq_4 = sequence_4::type_id::create("seq_4");
  endfunction

  task body;
    //Settting the arbitration scheme
    m_sequencer.set_arbitration(UVM_SEQ_ARB_WEIGHTED);

    //Start the sequences with defined priorities
    fork
      seq_1.start(m_sequencer,this,100);
      seq_2.start(m_sequencer,this,200);
      seq_3.start(m_sequencer,this,400);
      seq_4.start(m_sequencer,this,200);
    join
  endtask: body

endclass
