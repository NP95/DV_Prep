module switch (clk,
	reset,
	ready_in,
	data_in,
	port_num,
	ready_out_0,
	ready_out_1,
	ready_out_2,
	ready_out_3,
	data_out_0,
	data_out_1,
	data_out_2,
	data_out_3);
input clk, reset,ready_in;
input [7:0] data_in;
input [1:0] port_num;
output reg ready_out_0;
output reg ready_out_1;
output reg ready_out_2;
output reg ready_out_3;
output [7:0] data_out_0;
output [7:0] data_out_1;
output [7:0] data_out_2;
output [7:0] data_out_3;

reg [7:0] data_out; 

assign data_out_0 = ready_out_0 ? data_out : 8'b0; 
assign data_out_1 = ready_out_1 ? data_out : 8'b0; 
assign data_out_2 = ready_out_2 ? data_out : 8'b0; 
assign data_out_3 = ready_out_3 ? data_out : 8'b0; 

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
		ready_out_0 = 1'b0;	
		ready_out_1 = 1'b0;	
		ready_out_2 = 1'b0;	
		ready_out_3 = 1'b0;	
	end
	else
	begin
		if(ready_in)
		begin
			case(port_num)
			2'b00 : begin
				ready_out_0 <= 1'b1;	
			        ready_out_1 = 1'b0;	
			        ready_out_2 = 1'b0;	
			        ready_out_3 = 1'b0;	
				data_out <= data_in;
			end
			2'b01 : begin
				ready_out_0 <= 1'b0;	
			        ready_out_1 = 1'b1;	
			        ready_out_2 = 1'b0;	
			        ready_out_3 = 1'b0;	
				data_out <= data_in;
			end
			2'b10 : begin
				ready_out_0 <= 1'b0;	
			        ready_out_1 = 1'b0;	
			        ready_out_2 = 1'b1;	
			        ready_out_3 = 1'b0;	
				data_out <= data_in;
			end
			2'b11 : begin
				ready_out_0 <= 1'b0;	
			        ready_out_1 = 1'b0;	
			        ready_out_2 = 1'b0;	
			        ready_out_3 = 1'b1;	
				data_out <= data_in;
			end
			endcase
		end
		else
		begin
			ready_out_0 = 1'b0;	
			ready_out_1 = 1'b0;	
			ready_out_2 = 1'b0;	
			ready_out_3 = 1'b0;	
		end
	end
end
endmodule
