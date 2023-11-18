//Adder interface
interface adder_interface();
  logic [3:0] sum;
  logic c_out;
  logic [3:0] a;
  logic [3:0] b;
  
  //Add modports below
  modport dut(output c_out, output sum,input a,input b);
  modport tb (input  c_out, input sum,output a,output  b);

endinterface 
