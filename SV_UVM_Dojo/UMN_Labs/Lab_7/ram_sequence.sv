class ram_transaction extends uvm_sequence_item;

  `uvm_object_utils(ram_transaction)
  
  rand bit [7:0] address;
  rand bit [15:0] data;
  bit rd_req; 
  bit wr_req;

  constraint c_address { address > 8'h3F; address < 8'hF0; }

  function new (string name = "");
    super.new(name);
  endfunction

endclass: ram_transaction

class rd_sequence extends uvm_sequence#(ram_transaction);

  `uvm_object_utils(rd_sequence)

  function new (string name = "");
    super.new(name);
  endfunction

  bit [7:0] read_address;

  task body;
    
      req = ram_transaction::type_id::create("req");

      start_item(req);

      req.address = read_address;
      req.rd_req = 1'b1;
      req.wr_req = 1'b0;
     
      finish_item(req);
    
  endtask: body

endclass: rd_sequence

class wr_sequence extends uvm_sequence#(ram_transaction);

  `uvm_object_utils(wr_sequence)

  function new (string name = "");
    super.new(name);
  endfunction

  bit [7:0] write_address;

  task body;
    
      req = ram_transaction::type_id::create("req");

      start_item(req);

      if (!req.randomize()) begin
        `uvm_error("WRITE_SEQUENCE", "Randomize failed.");
      end

      req.rd_req = 1'b0;
      req.wr_req = 1'b1;
     
      write_address = req.address;

      finish_item(req);
    
  endtask: body

endclass: wr_sequence

class ram_sequence extends uvm_sequence#(ram_transaction);

  `uvm_object_utils(ram_sequence)

  function new (string name = "");
    super.new(name);
  endfunction

  rd_sequence rd_seq;
  wr_sequence wr_seq;

  bit [7:0] write_address [0:7];

  task body;
    
     for(int i =0;i<8;i++) 
     begin
       wr_seq = wr_sequence::type_id::create("wr_seq");
       wr_seq.start(m_sequencer);
       write_address[i] = wr_seq.write_address;
     end
     for(int i =0;i<8;i++) 
     begin
       rd_seq = rd_sequence::type_id::create("rd_seq");
       rd_seq.read_address = write_address[i];
       rd_seq.start(m_sequencer);
     end
    
  endtask: body

endclass: ram_sequence


