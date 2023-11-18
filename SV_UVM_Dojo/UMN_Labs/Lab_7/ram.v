module ram (input  clk,
            input  [7:0] address,
            inout  [15:0] data,
            input  rd_req,
            input  wr_req,
            output rd_valid);
  
  reg [15:0] data_out ;
  reg [15:0] mem [0:255];
  reg rd_valid_reg;
  
  assign data = (rd_valid_reg) ? data_out : 16'bz;
  assign rd_valid = rd_valid_reg;  

  always @ (posedge clk)
  begin 
    if ( wr_req ) begin
         mem[address] = data;
     end
  end
  
  always @ (posedge clk)
  begin 
    if (rd_req) begin
      data_out = mem[address];
      rd_valid_reg = 1;
   end else begin
      rd_valid_reg = 0;
    end
  end
  
endmodule
            
