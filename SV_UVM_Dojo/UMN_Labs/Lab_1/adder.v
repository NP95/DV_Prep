module full_adder (output sum, output c_out, input a, input b, input c_in);
  assign sum = a^b^c_in;
  assign c_out = (a&b)|((a^b)&c_in);
endmodule

module adder  (adder_interface.dut dut_mp);

  wire [2:0] c_out;
  
  full_adder f_ad0 (dut_mp.sum[0],c_out[0],dut_mp.a[0],dut_mp.b[0],1'b0);
  full_adder f_ad1 (dut_mp.sum[1],c_out[1],dut_mp.a[1],dut_mp.b[1],c_out[0]);
  full_adder f_ad2 (dut_mp.sum[2],c_out[2],dut_mp.a[2],dut_mp.b[2],c_out[1]);
  full_adder f_ad3 (dut_mp.sum[3],dut_mp.c_out,dut_mp.a[3],dut_mp.b[3],c_out[2]);  

endmodule 
