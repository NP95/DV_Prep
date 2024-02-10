//Author: Nishant Pani
`include "uvm_macros.svh"
 import uvm_pkg::*;
 
/////////////build the seq for random length with and without priority
 
////////////////////////////////////////////////////////////////////////////////////
class uart_config extends uvm_object; /////configuration of env
  `uvm_object_utils(uart_config)
  
  function new(string name = "uart_config");
    super.new(name);
  endfunction
  
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
endclass
 
//////////////////////////////////////////////////////////
 
typedef enum bit [3:0]   {rand_baud_1_stop = 0, rand_length_1_stop = 1, length5wp = 2, length6wp = 3, length7wp = 4, length8wp = 5, length5wop = 6, length6wop = 7, length7wop = 8, length8wop = 9,rand_baud_2_stop = 11, rand_length_2_stop = 12} oper_mode;
 
 
class uart_transaction extends uvm_sequence_item;
  `uvm_object_utils(uart_transaction)
  
    rand oper_mode   op;
         logic tx_start, rx_start;
         logic rst;
    rand logic [7:0] tx_data;
    rand logic [16:0] baud;
    rand logic [3:0] length; 
    rand logic parity_type, parity_en;
         logic stop2;
         logic tx_done, rx_done, tx_err, rx_err;
         logic [7:0] rx_out;
  
 
  //Constraints for Baud length and packet lengths  
  constraint baud_c { baud inside {4800,9600,14400,19200,38400,57600}; }
  constraint length_c { length inside {5,6,7,8}; }
 
  function new(string name = "uart_transaction");
    super.new(name);
  endfunction
 
endclass : uart_transaction
///////////////////////////////////////////////////////////////////////
///////////////////random baud - fixed length = 8 - parity enable - parity type : random - single stop
class rand_baud extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud)
  
  uart_transaction rand_baud;
 
  function new(string name = "rand_baud");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud = uart_transaction::type_id::create("rand_baud");
        start_item(rand_baud);
        assert(rand_baud.randomize);
        rand_baud.op     = rand_baud_1_stop;
        rand_baud.length = 8;
        rand_baud.rst       = 1'b0;
        rand_baud.tx_start  = 1'b1;
        rand_baud.rx_start  = 1'b1;
        rand_baud.parity_en = 1'b1;
        rand_baud.stop2     = 1'b0;
        finish_item(rand_baud);
      end
  endtask
  
 
endclass
////////////////////random baud - fixed length = 8 - parity enable - parity type : random - two stop
//////////////////////////////////////////////////////////
class rand_baud_with_stop extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud_with_stop)
  
  uart_transaction rand_baud_stop;
 
  function new(string name = "rand_baud_with_stop");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud_stop = uart_transaction::type_id::create("rand_baud_stop");
        start_item(rand_baud_stop);
        assert(rand_baud_stop.randomize);
        rand_baud_stop.op        = rand_baud_2_stop;
        rand_baud_stop.rst       = 1'b0;
        rand_baud_stop.length    = 8;
        rand_baud_stop.tx_start  = 1'b1;
        rand_baud_stop.rx_start  = 1'b1;
        rand_baud_stop.parity_en = 1'b1;
        rand_baud_stop.stop2     = 1'b1;
        finish_item(rand_baud_stop);
      end
  endtask
  
 
endclass
 
//////////////////////////////////////////////////////////
////////////////////fixed length = 5 - variable baud - with parity
class rand_baud_len5p extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud_len5p)
  
  uart_transaction rand_baud_len5p;
 
  function new(string name = "rand_baud_len5p");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud_len5p = uart_transaction::type_id::create("rand_baud_len5p");
        start_item(rand_baud_len5p);
        assert(rand_baud_len5p.randomize);
        rand_baud_len5p.op     = length5wp;
        rand_baud_len5p.rst       = 1'b0;
        rand_baud_len5p.tx_data   = {3'b000, rand_baud_len5p.tx_data[7:3]};
        rand_baud_len5p.length = 5;
        rand_baud_len5p.tx_start  = 1'b1;
        rand_baud_len5p.rx_start  = 1'b1;
        rand_baud_len5p.parity_en = 1'b1;
        rand_baud_len5p.stop2     = 1'b0;
        finish_item(rand_baud_len5p);
      end
  endtask
  
 
endclass
 
 
 
//////////////////////////////////////////////////////////
////////////////////fixed length = 6 - variable baud - with parity
class rand_baud_len6p extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud_len6p)
  
  uart_transaction rand_baud_len6p;
 
  function new(string name = "rand_baud_len6p");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud_len6p = uart_transaction::type_id::create("rand_baud_len6p");
        start_item(rand_baud_len6p);
        assert(rand_baud_len6p.randomize);
        rand_baud_len6p.op     = length6wp;
        rand_baud_len6p.rst       = 1'b0;
        rand_baud_len6p.length = 6;
        rand_baud_len6p.tx_data   = {2'b00, rand_baud_len6p.tx_data[7:2]};
        rand_baud_len6p.tx_start  = 1'b1;
        rand_baud_len6p.rx_start  = 1'b1;
        rand_baud_len6p.parity_en = 1'b1;
        rand_baud_len6p.stop2     = 1'b0;
        finish_item(rand_baud_len6p);
      end
  endtask
  
 
endclass
 
//////////////////////////////////////////////////////////
////////////////////fixed length = 7 - variable baud - with parity
class rand_baud_len7p extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud_len7p)
  
  uart_transaction rand_baud_len7p;
 
  function new(string name = "rand_baud_len7p");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud_len7p = uart_transaction::type_id::create("rand_baud_len7p");
        start_item(rand_baud_len7p);
        assert(rand_baud_len7p.randomize);
        rand_baud_len7p.op     = length7wp;
        rand_baud_len7p.rst       = 1'b0;
        rand_baud_len7p.length = 7;
        rand_baud_len7p.tx_data   = {1'b0, rand_baud_len7p.tx_data[7:1]};
        rand_baud_len7p.tx_start  = 1'b1;
        rand_baud_len7p.rx_start  = 1'b1;
        rand_baud_len7p.parity_en = 1'b1;
        rand_baud_len7p.stop2     = 1'b0;
        finish_item(rand_baud_len7p);
      end
  endtask
  
 
endclass
 
//////////////////////////////////////////////////////////
////////////////////fixed length = 8 - variable baud - with parity
class rand_baud_len8p extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud_len8p)
  
  uart_transaction rand_baud_len8p;
 
  function new(string name = "rand_baud_len8p");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud_len8p = uart_transaction::type_id::create("rand_baud_len8p");
        start_item(rand_baud_len8p);
        assert(rand_baud_len8p.randomize);
        rand_baud_len8p.op     = length8wp;
        rand_baud_len8p.rst       = 1'b0;
        rand_baud_len8p.length = 8;
        rand_baud_len8p.tx_data   =  rand_baud_len8p.tx_data[7:0];
        rand_baud_len8p.tx_start  = 1'b1;
        rand_baud_len8p.rx_start  = 1'b1;
        rand_baud_len8p.parity_en = 1'b1;
        rand_baud_len8p.stop2     = 1'b0;
        finish_item(rand_baud_len8p);
      end
  endtask
  
 
endclass
 
//////////////////////////////////////////////////////////
////////////////////fixed length = 5 - variable baud - without parity
class rand_baud_len5 extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud_len5)
  
  uart_transaction rand_baud_len5nop;
 
  function new(string name = "rand_baud_len5");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud_len5nop = uart_transaction::type_id::create("rand_baud_len5nop");
        start_item(rand_baud_len5nop);
        assert(rand_baud_len5nop.randomize);
        rand_baud_len5nop.op     = length5wop;
        rand_baud_len5nop.rst       = 1'b0;
        rand_baud_len5nop.length = 5;
        rand_baud_len5nop.tx_data   = {3'b000, rand_baud_len5nop.tx_data[7:3]};
        rand_baud_len5nop.tx_start  = 1'b1;
        rand_baud_len5nop.rx_start  = 1'b1;
        rand_baud_len5nop.parity_en = 1'b0;
        rand_baud_len5nop.stop2     = 1'b0;
        finish_item(rand_baud_len5nop);
      end
  endtask
  
 
endclass
 
 
//////////////////////////////////////////////////////////
////////////////////fixed length = 6- variable baud - without parity
class rand_baud_len6 extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud_len6)
  
  uart_transaction rand_baud_len6nop;
 
  function new(string name = "rand_baud_len6");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud_len6nop = uart_transaction::type_id::create("rand_baud_len6nop");
        start_item(rand_baud_len6nop);
        assert(rand_baud_len6nop.randomize);
        rand_baud_len6nop.op     = length6wop;
        rand_baud_len6nop.rst       = 1'b0;
        rand_baud_len6nop.length = 6;
        rand_baud_len6nop.tx_data   = {2'b00, rand_baud_len6nop.tx_data[7:2]};
        rand_baud_len6nop.tx_start  = 1'b1;
        rand_baud_len6nop.rx_start  = 1'b1;
        rand_baud_len6nop.parity_en = 1'b0;
        rand_baud_len6nop.stop2     = 1'b0;
        finish_item(rand_baud_len6nop);
      end
  endtask
  
 
endclass
//////////////////////////////////////////////////////////
////////////////////fixed length = 7- variable baud - without parity
class rand_baud_len7 extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud_len7)
  
  uart_transaction rand_baud_len7nop;
 
  function new(string name = "rand_baud_len7");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud_len7nop = uart_transaction::type_id::create("rand_baud_len7nop");
        start_item(rand_baud_len7nop);
        assert(rand_baud_len7nop.randomize);
        rand_baud_len7nop.op     = length7wop;
        rand_baud_len7nop.rst       = 1'b0;
        rand_baud_len7nop.length = 7;
        rand_baud_len7nop.tx_data   = {1'b0, rand_baud_len7nop.tx_data[7:1]};
        rand_baud_len7nop.tx_start  = 1'b1;
        rand_baud_len7nop.rx_start  = 1'b1;
        rand_baud_len7nop.parity_en = 1'b0;
        rand_baud_len7nop.stop2     = 1'b0;
        finish_item(rand_baud_len7nop);
      end
  endtask
  
 
endclass

 
//////////////////////////////////////////////////////////
////////////////////fixed length = 8 - variable baud - without parity
class rand_baud_len8 extends uvm_sequence#(uart_transaction);
  `uvm_object_utils(rand_baud_len8)
  
  uart_transaction rand_baud_len8nop;
 
  function new(string name = "rand_baud_len8");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        rand_baud_len8nop = uart_transaction::type_id::create("rand_baud_len8nop");
        start_item(rand_baud_len8nop);
        assert(rand_baud_len8nop.randomize);
        rand_baud_len8nop.op     = length8wop;
        rand_baud_len8nop.rst       = 1'b0;
        rand_baud_len8nop.length = 8;
        rand_baud_len8nop.tx_data   =  rand_baud_len8nop.tx_data[7:0];
        rand_baud_len8nop.tx_start  = 1'b1;
        rand_baud_len8nop.rx_start  = 1'b1;
        rand_baud_len8nop.parity_en = 1'b0;
        rand_baud_len8nop.stop2     = 1'b0;
        finish_item(rand_baud_len8nop);
      end
  endtask
  
 
endclass
 
 
///////////////////////////////////////////////////////////////////////////////////////
 
 
 
 
class driver extends uvm_driver #(uart_transaction);
  `uvm_component_utils(driver)
  
  virtual uart_if vif;
  uart_transaction tr;
  
  
  function new(input string path = "drv", uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
 virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     tr = uart_transaction::type_id::create("tr");
      
   if(!uvm_config_db#(virtual uart_if)::get(this,"","vif",vif)) 
      `uvm_error("drv","Unable to access Interface");
  endfunction
  
  
  
  task reset_dut();
 
    repeat(5) 
    begin
    vif.rst      <= 1'b1;  ///active high reset
    vif.tx_start <= 1'b0;
    vif.rx_start <= 1'b0;
    vif.tx_data  <= 8'h00;
    vif.baud     <= 16'h0;
    vif.length   <= 4'h0;
    vif.parity_type <= 1'b0;
    vif.parity_en   <= 1'b0;
    vif.stop2  <= 1'b0;
   `uvm_info("DRV", "System Reset : Start of Simulation", UVM_MEDIUM);
    @(posedge vif.clk);
      end
  endtask
  
  task drive();
    reset_dut();
   forever begin
     
         seq_item_port.get_next_item(tr);
     
                                             
                            vif.rst         <= 1'b0;
                            vif.tx_start    <= tr.tx_start;
                            vif.rx_start    <= tr.rx_start;
                            vif.tx_data     <= tr.tx_data;
                            vif.baud        <= tr.baud;
                            vif.length      <= tr.length;
                            vif.parity_type <= tr.parity_type;
                            vif.parity_en   <= tr.parity_en;
                            vif.stop2       <= tr.stop2;
     `uvm_info("DRV", $sformatf("BAUD:%0d LEN:%0d PAR_T:%0d PAR_EN:%0d STOP:%0d TX_DATA:%0d", tr.baud, tr.length, tr.parity_type, tr.parity_en, tr.stop2, tr.tx_data), UVM_NONE);
                            @(posedge vif.clk); 
                            @(posedge vif.tx_done);
     @(negedge vif.rx_done);
                            
     
       seq_item_port.item_done();
     
   end
  endtask
  
 
  virtual task run_phase(uvm_phase phase);
    drive();
  endtask
 
  
endclass
 
//////////////////////////////////////////////////////////////////////////////////////////////
 
class mon extends uvm_monitor;
`uvm_component_utils(mon)
 
uvm_analysis_port#(uart_transaction) send;
uart_transaction tr;
virtual uart_if vif;
 
    function new(input string inst = "mon", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = uart_transaction::type_id::create("tr");
    send = new("send", this);
      if(!uvm_config_db#(virtual uart_if)::get(this,"","vif",vif))//uvm_test_top.env.agent.drv.aif
        `uvm_error("MON","Unable to access Interface");
    endfunction
    
    
    virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      if(vif.rst)
        begin
          tr.rst = 1'b1;
        `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);
        send.write(tr);
        end
      else
         begin
         @(posedge vif.tx_done);
         tr.rst         = 1'b0;
         tr.tx_start    = vif.tx_start;
         tr.rx_start    = vif.rx_start;
         tr.tx_data     = vif.tx_data;
         tr.baud        = vif.baud;
         tr.length      = vif.length;
         tr.parity_type = vif.parity_type;
         tr.parity_en   = vif.parity_en;
         tr.stop2       = vif.stop2;
           @(negedge vif.rx_done);
         
         tr.rx_out      = vif.rx_out;
           `uvm_info("MON", $sformatf("BAUD:%0d LEN:%0d PAR_T:%0d PAR_EN:%0d STOP:%0d TX_DATA:%0d RX_DATA:%0d", tr.baud, tr.length, tr.parity_type, tr.parity_en, tr.stop2, tr.tx_data, tr.rx_out), UVM_NONE);
          send.write(tr);
         end
    
    
    end
   endtask 
 
endclass
//////////////////////////////////////////////////////////////////////////////////////////////////
 
class sco extends uvm_scoreboard;
`uvm_component_utils(sco)
 
  uvm_analysis_imp#(uart_transaction,sco) recv;
  bit [31:0] arr[32] = '{default:0};
  bit [31:0] addr    = 0;
  bit [31:0] data_rd = 0;
 
 
 
    function new(input string inst = "sco", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("recv", this);
    endfunction
    
    
  virtual function void write(uart_transaction tr);
    `uvm_info("SCO", $sformatf("BAUD:%0d LEN:%0d PAR_T:%0d PAR_EN:%0d STOP:%0d TX_DATA:%0d RX_DATA:%0d", tr.baud, tr.length, tr.parity_type, tr.parity_en, tr.stop2, tr.tx_data, tr.rx_out), UVM_NONE);
    if(tr.rst == 1'b1)
      `uvm_info("SCO", "System Reset", UVM_NONE)
    else if(tr.tx_data == tr.rx_out)
      `uvm_info("SCO", "Test Passed", UVM_NONE)
    else
      `uvm_info("SCO", "Test Failed", UVM_NONE)
    $display("----------------------------------------------------------------");
    endfunction
 
endclass
 
 
//////////////////////////////////////////////////////////////////////////////////////////////
                  
                  
class agent extends uvm_agent;
`uvm_component_utils(agent)
  
  uart_config cfg;
 
function new(input string inst = "agent", uvm_component parent = null);
super.new(inst,parent);
endfunction
 
 driver d;
 uvm_sequencer#(uart_transaction) seqr;
 mon m;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
   cfg =  uart_config::type_id::create("cfg"); 
   m = mon::type_id::create("m",this);
  
  if(cfg.is_active == UVM_ACTIVE)
   begin   
   d = driver::type_id::create("d",this);
   seqr = uvm_sequencer#(uart_transaction)::type_id::create("seqr", this);
   end
  
  
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
  if(cfg.is_active == UVM_ACTIVE) begin  
    d.seq_item_port.connect(seqr.seq_item_export);
  end
endfunction
 
endclass
 
//////////////////////////////////////////////////////////////////////////////////
 
class env extends uvm_env;
`uvm_component_utils(env)
 
function new(input string inst = "env", uvm_component c);
super.new(inst,c);
endfunction
 
agent a;
sco s;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  a = agent::type_id::create("a",this);
  s = sco::type_id::create("s", this);
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
 a.m.send.connect(s.recv);
endfunction
 
endclass
 
//////////////////////////////////////////////////////////////////////////
 
class test extends uvm_test;
`uvm_component_utils(test)
 
function new(input string inst = "test", uvm_component c);
super.new(inst,c);
endfunction
 
 
env e;
  
rand_baud rb;
rand_baud_with_stop rbs;
rand_baud_len5p  rb5l;
rand_baud_len6p rb6l;
rand_baud_len7p rb7l;
rand_baud_len8p rb8l;
  ///////////////////////
  
  rand_baud_len5  rb5lwop;
  rand_baud_len6  rb6lwop;
  rand_baud_len7  rb7lwop;
  rand_baud_len8  rb8lwop;
  
  
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  e       = env::type_id::create("env",this);
   rb      = rand_baud::type_id::create("rb");
   rbs     = rand_baud_with_stop::type_id::create("rbs");
  /////////////fixed length var baud with parity
   rb5l    = rand_baud_len5p::type_id::create("rb5l");
   rb6l    = rand_baud_len6p::type_id::create("rb6l");
   rb7l    = rand_baud_len7p::type_id::create("rb7l");
   rb8l    = rand_baud_len8p::type_id::create("rb8l");
  
  ///////////////fixed len var baud without parity
  rb5lwop = rand_baud_len5::type_id::create("rb5lwop");
  rb6lwop = rand_baud_len6::type_id::create("rb6lwop");
  rb7lwop = rand_baud_len7::type_id::create("rb7lwop");
  rb8lwop = rand_baud_len8::type_id::create("rb8lwop");
  
  
endfunction
 
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
rb8lwop.start(e.a.seqr);
#20;
phase.drop_objection(this);
endtask
endclass
 
//////////////////////////////////////////////////////////////////////
  
module tb;
  
  
  uart_if vif();
  
 
  
  
  uart_top dut (.clk(vif.clk), .rst(vif.rst), .tx_start(vif.tx_start), .rx_start(vif.rx_start), .tx_data(vif.tx_data), .baud(vif.baud), .length(vif.length), .parity_type(vif.parity_type), .parity_en(vif.parity_en),.stop2(vif.stop2),.tx_done(vif.tx_done), .rx_done(vif.rx_done), .tx_err(vif.tx_err), .rx_err(vif.rx_err), .rx_out(vif.rx_out));
  
  initial begin
    vif.clk <= 0;
  end
 
  always #10 vif.clk <= ~vif.clk;
 
  
  
  initial begin
    uvm_config_db#(virtual uart_if)::set(null, "*", "vif", vif);
    run_test("test");
   end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
  
endmodule

