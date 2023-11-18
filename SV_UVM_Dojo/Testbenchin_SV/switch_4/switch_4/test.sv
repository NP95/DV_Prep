
program test;

packet pkt1 = new();
packet pkt2 = new();
logic [7:0] bytes[];
initial
repeat(10)
if(pkt1.randomize)
begin
$display(" Randomization Sucessesfull.");
pkt1.display();
void'(pkt1.byte_pack(bytes));
pkt2 = new();
pkt2.byte_unpack(bytes);
if(pkt2.compare(pkt1))
$display(" Packing,Unpacking and compare worked");
else
$display(" *** Something went wrong in Packing or Unpacking or compare ***");

end
else
$display(" *** Randomization Failed ***");

endprogram


