class ram_subscriber extends uvm_subscriber #(ram_transaction);
//Register subscriber in uvm factory

//Define variables to store read/write request and address

//Define covergroup and coverpoints

//Declare virtual interface object

//Declare analysis port to get transactions from monitor



  function new (string name, uvm_component parent);
  begin
    super.new(name,parent);

    //Call new for covergroup

  end
  endfunction

  function void build_phase(uvm_phase phase);
    // Get virtual interface reference from config database

    //Instantiate analysis port

  endfunction 

  //Write function for the analysis port

endclass








