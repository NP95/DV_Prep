/* pci_master.v module

   This is a simple behavioral model that drives only a
   simple (canned!) PCI Read Transaction from the master.
   This is -not- a complete PCI master model.
   

*/
                                                                                                   
module pci_master (input bit clk, reset_,
		   input logic TRDY_, DEVSEL_,
           output logic FRAME_, IRDY_,
		   output logic [3:0] C_BE_,
           inout wire [31:0] AD
);

reg [31:0] data [0:7];

bit AD_enb;
reg [31:0] AD_reg;
assign AD = AD_enb ? AD_reg:32'hZ;
reg READ_DONE, WRITE_DONE;

 
  always @(posedge test_pci_protocol.READ)
    begin
    READ_DONE=0;
    @(negedge clk);

      $display("\n\tPCI_MASTER: READ CYCLE START");

	//de-assert control signals
	FRAME_=1'b1; IRDY_=1'b1; 	
	
	//Don't drive AD - yet.
	AD_enb=1'b0;

	//On de-assertion of reset_

	//Drive FRAME_, AD and C_BE_ (for a memory read)
	@(negedge clk); 
		FRAME_ = 1'b0;
		//AD_enb=1'b1;
		C_BE_ = 4'b 0110;
		$display("\n","\tREAD CYCLE: Drive FRAME_, AD and Read Command");

	//Start the cycle (and drive Byte Enables)
	@(negedge clk);
		IRDY_ = 1'b0;
		AD_enb=1'b0;

	//Wait for TRDY_ to assert
	@(negedge TRDY_);

	//Read data received
	  if (! DEVSEL_) data[0] = AD;
      $display("\n","\tREAD CYCLE: \tData Transfer Phase");

	//Wait for the next TRDY_ to assert
	@(negedge TRDY_);

	//Read data received
      if (! DEVSEL_ && !TRDY_) data[1] = AD;
      $display("\n","\tREAD CYCLE: \tData Transfer Phase");

	//Insert a wait state from the master
	@(negedge clk);
		IRDY_ = 1'b1;
		$display("\n","\tREAD CYCLE: Master Wait Mode");

	//Remove wait state
	@(negedge clk);
	  if (! DEVSEL_ && !TRDY_) data[1] = AD;
		IRDY_ = 1'b0;
		$display("\n","\tREAD CYCLE: Data Transfer Phase");

	//De-assert FRAME_
	@(negedge clk);
		FRAME_ = 1'b1;
		$display("\n","\tREAD CYCLE: FRAME_ De-asserted");

	//De-assert IRDY_
	@(negedge clk);
		IRDY_ = 1'b1;
        $display("\n","\tREAD CYCLE COMPLETE"); 
        READ_DONE=1; 
    end

  always @(posedge test_pci_protocol.WRITE)
    begin
      WRITE_DONE = 0;
    @(negedge clk);

      $display("\n\tPCI_MASTER: WRITE CYCLE START");
      @(posedge clk);
      C_BE_ = 4'b 0111;
      
      AD_enb = 1'b1; AD_reg = 32'h FFFF; C_BE_ = 4'b 1010;
      @(posedge clk);
      AD_enb = 1'b1; AD_reg = 32'h FFFF_0000;C_BE_ = 4'b 0101;
      @(posedge clk);
      AD_enb = 1'b1; AD_reg = 32'h F0F0_F0F0;C_BE_ = 4'b 0011;
      @(posedge clk);
      AD_enb = 1'b1; AD_reg = 32'h 1234_5678;C_BE_ = 4'b 1100;
      
      repeat (3) begin @(posedge clk); end
      $display("\tPCI_MASTER: WRITE CYCLE END\n");
      WRITE_DONE=1;
    end
      
endmodule

