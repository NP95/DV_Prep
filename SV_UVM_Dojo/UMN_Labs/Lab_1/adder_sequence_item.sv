//Sequence item class
class sequence_item;
  
  //Inputs to be randomized
  rand bit [3:0] a,b;
  
  //Add constraints below
  constraint input_constraint
   {
     a inside {[4'd0:4'd15]};
     b inside {[4'd0:4'd15]};
   }
  //new function for sequence item class    
  function new();
  begin
    a = 0;
    b = 0;
  end
  endfunction
  
endclass
