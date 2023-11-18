/* test_pci_protocol.sv module
*/

module test_pci_protocol;
logic clk, reset_;

wire TRDY_, DEVSEL_;
wire FRAME_, IRDY_;
wire [3:0] C_BE_;
wire [31:0] AD;
wire [1:0] pciC;
  
bit READ, WRITE;
real coverPercent1, coverPercent2, coverPercent3, coverPercent4, coverPercent5, coverPercent6 ;

pci_master pcim (clk, reset_, TRDY_, DEVSEL_, FRAME_, IRDY_, C_BE_, AD);
pci_target pcit (clk, reset_, TRDY_, DEVSEL_, FRAME_, IRDY_, C_BE_, AD);
                                                                                                   
initial begin 
  clk=1; reset_=1; 
  $dumpfile("PCI.vcd"); 
  $dumpvars; 
end
  
always #5 clk=!clk;

initial
begin
  READ=0;
  //MASTER READ
  @(negedge clk);
  READ = 1; @(negedge clk);  READ=0;
  
  @(posedge pcim.READ_DONE);
  
  //MASTER READ
  READ=0;
  @(negedge clk);
  READ = 1; @(negedge clk);  
  
  @(posedge pcim.READ_DONE); READ=0;
  
  //MASTER WRITE
  WRITE=0;
  @(negedge clk);
  WRITE = 1; @(negedge clk);   WRITE=0;

  @(posedge pcim.WRITE_DONE);
  
  //MASTER READ
  READ = 0;
  @(negedge clk);
  READ = 1; @(negedge clk);  
  
  @(posedge pcim.READ_DONE); READ=0;
  
  //MASTER WRITE
  WRITE=0;
  @(negedge clk);
  WRITE = 1; @(negedge clk);   WRITE=0;
  
  @(posedge pcim.WRITE_DONE);
  
    //MASTER WRITE
  WRITE=0;
  @(negedge clk);
  WRITE = 1; @(negedge clk);   WRITE=0;
  
  @(posedge pcim.WRITE_DONE);

  @(negedge clk);
  
  coverPercent1 = pci_cycles_inst.get_coverage( ); 
  $display("\n \tCoverage for pci_cycles_inst is %f",coverPercent1);
  
  coverPercent2 = Byteenables_inst.get_coverage( ); 
  $display("\n \tCoverage for ByteEnables_inst is %f",coverPercent2);
  
  coverPercent3 = pciTrans_inst.get_coverage( ); 
  $display("\n \tCoverage for pciTrans_inst is %f",coverPercent3);
  
  coverPercent4 = Enables_inst.get_coverage( ); 
  $display("\n \tCoverage for Enables_inst is %f",coverPercent4);
  
  coverPercent5 = ad_inst.get_coverage( ); 
  $display("\n \tCoverage for ad_inst is %f",coverPercent5);
  
  coverPercent6 = irtr_cross_inst.get_coverage( ); 
  $display("\n \tCoverage for irtr_cross_inst is %f",coverPercent6);
  
  $display("\n");
  
  @(negedge clk); $finish(2);
end

always @(posedge clk)
  $display($stime,,,"clk=%b reset_=%b FRAME_=%b AD=%h C_BE_=%b IRDY_=%b TRDY_=%b DEVSEL_=%b READ=%b WRITE=%b",clk, reset_, FRAME_, AD, C_BE_, IRDY_, TRDY_, DEVSEL_, READ, WRITE);
  
  covergroup pci_cycles @(posedge clk);
  //CODE HERE: Cover READ and WRITE cycles
   r: coverpoint READ;
   w: coverpoint WRITE;
  endgroup
  
  covergroup ByteEnables @(posedge clk);
  //CODE HERE: Cover C_BE_
    rw: coverpoint  C_BE_;
  endgroup
  
  covergroup pciTrans @(posedge clk);
  //CODE HERE: Cover all 4 transitions: READ=>READ, READ=>WRITE, WRITE=>READ, WRITE=>WRITE
    pc: coverpoint {READ,WRITE}
    { 
      //bins rd_wr_tran [ ] = (0,1 => 0,1);
      bins rd_wr_tran [ ] = (READ,WRITE => READ,WRITE);
    }
  endgroup
  
  covergroup Enables @(posedge clk);
  //CODE HERE: Cover all enables: TRDY_, DEVSEL_, FRAME_, IRDY_
    en: coverpoint TRDY_;
    db: coverpoint DEVSEL_;
    fb: coverpoint FRAME_;
    ib: coverpoint IRDY_;
  endgroup
  
 
  covergroup ad @(posedge clk);
    //CODE HERE: Cover AD into 4 bins
    adc: coverpoint AD
    {
      bins adbins [4] = {[0:'hFFFF_FFFF]};
    }
  endgroup
  
  covergroup irtr_cross @(posedge clk);
    //CODE HERE: cross IRDY_ and TRDY_
     crg: cross IRDY_,TRDY_;
  endgroup
 
  pci_cycles pci_cycles_inst = new();
  ByteEnables Byteenables_inst = new();
  pciTrans pciTrans_inst = new();
  Enables Enables_inst = new();
  ad ad_inst = new();
  irtr_cross irtr_cross_inst = new();

endmodule
