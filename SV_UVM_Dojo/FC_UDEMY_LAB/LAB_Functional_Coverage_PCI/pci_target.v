/* pci_target.v module

   This is a simple behavioral model that drives only a
   simple (canned!) PCI Read Transaction from the target.
   This is -not- a complete PCI target model.

*/
                                                                                                   
module pci_target (input bit clk, reset_,
		   output logic TRDY_, DEVSEL_,
                   input logic FRAME_, IRDY_,
		   input logic [3:0] C_BE_,
                   inout wire [31:0] AD
);

bit AD_enb;
reg [31:0] AD_reg;
assign AD = AD_enb ? AD_reg:32'hZ;

always @(posedge test_pci_protocol.READ)
begin  //TARGET WRITE

	//Keep AD float...until you want to drive data on it
	//You are not yet selected, so keep DEVSEL_ de-asserted
	AD_enb = 1'b0;
	DEVSEL_ = 1'b1;

	//On assertion of IRDY_ 
	@(negedge IRDY_);

	//Drive DEVSEL_

		DEVSEL_=1'b0; 

  $display("\tTARGET WRITE: TARGET selected");

	//Drive TRDY_  and data
	@(negedge clk); 
  if (IRDY_ == 1'b0)
    begin
		TRDY_ = 1'b0;
		AD_reg = 32'h CAFE_CAFE; AD_enb = 1'b1;
      $display("\tTARGET WRITE: TARGET DATA DRIVEN = %h",AD_reg);
    end

	//Insert a WAIT state
	@(negedge clk);
		TRDY_ = 1'b1;
		AD_enb = 1'b0;
                $display("\n","\tTARGET Wait Mode");

	//Drive TRDY_  and second data
	@(negedge clk); 
		TRDY_ = 1'b0;
		AD_reg = 32'h FACE_FACE; AD_enb = 1'b1;
        $display("\tTARGET WRITE: TARGET DATA DRIVEN = %h",AD_reg);

	//Drive TRDY_  and third data
	@(negedge clk); 
		TRDY_ = 1'b0;
		AD_reg = 32'h CAFE_FACE; AD_enb = 1'b1;
        $display("\tTARGET WRITE: TARGET DATA DRIVEN = %h",AD_reg);

	@(negedge clk); 
	//De-assert TRDY_ and DEVSEL_
	@(negedge clk);
		TRDY_ = 1'b1;
		DEVSEL_ = 1'b1;
		AD_enb = 1'b0;
                 $display("\tTARGET WRITE: COMPLETE");

end
endmodule
