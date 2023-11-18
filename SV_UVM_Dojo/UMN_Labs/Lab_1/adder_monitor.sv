//Adder monitor class
class monitor;

  //Define virtual interface
  virtual adder_interface.tb tb_ports;
  
  //Internal variable to calculate sum
  bit [4:0] sum;
  
  //New function
  function new(virtual adder_interface.tb ports);
  begin
    tb_ports = ports;
  end
  endfunction
  
  //Monitor task
  task monitor_t();
  begin
      sum = tb_ports.a + tb_ports.b;
      //Add monitor statements below            
      if((tb_ports.sum != sum[3:0])||(tb_ports.c_out!= sum[4]))
      begin
      $display("Actual sum - %d actual carry - %d expected sum - %d expected carry -%d\n",tb_ports.sum,tb_ports.c_out,sum[3:0],sum[4]);
    end
  end
  endtask 
endclass
