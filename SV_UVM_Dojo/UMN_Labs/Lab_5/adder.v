module full_adder (output sum, output c_out, input a, input b, input c_in);
  assign sum = a^b^c_in;
  assign c_out = (a&b)|((a^b)&c_in);
endmodule

module adder  (adder_interface dut);

  wire [2:0] c_out;
  
  full_adder f_ad0 (dut.sum[0],c_out[0],dut.a[0],dut.b[0],1'b0);
  full_adder f_ad1 (dut.sum[1],c_out[1],dut.a[1],dut.b[1],c_out[0]);
  full_adder f_ad2 (dut.sum[2],c_out[2],dut.a[2],dut.b[2],c_out[1]);
  full_adder f_ad3 (dut.sum[3],dut.c_out,dut.a[3],dut.b[3],c_out[2]);  


endmodule 
