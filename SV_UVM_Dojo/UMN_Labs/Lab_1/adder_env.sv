//Adder TB Environment class
module adder_env(adder_interface.tb tb_mp);
    
  //Instantiate driver, monitor and sequence items below
  driver drv =new(tb_mp);
  monitor mon =new(tb_mp);
  sequence_item s0 = new();
  sequence_item s1 = new();
  initial
  begin
    forever
    begin
      #2;
      //Call monitor task below
   mon.monitor_t(); 
    end
  end

  initial 
  begin 
    //Write code to randomize sequence items and send them to driver
    if(s0.randomize() == 1)
    begin
       drv.drive_t(s0);
    end
    #15;

    if(s1.randomize() == 1)
    begin
        drv.drive_t(s1);
    end 
    #100 $finish;
  end 
endmodule   
  
  
  
  
  
  
  

