//Adder Driver class
class driver;

  //Defining virtual interface
  virtual adder_interface.tb tb_ports;
  
  //New function
  function new(virtual adder_interface.tb ports);
  begin
    tb_ports = ports;
  end
  endfunction
  
  //Driver task
  task drive_t(sequence_item item);
  begin      
    $display("Driving a - %d b - %d time %g \n",item.a,item.b,$time);
    //Drive a and b DUT inputs below
    tb_ports.a = item.a;
    tb_ports.b = item.b;
  end
  endtask
  
endclass
