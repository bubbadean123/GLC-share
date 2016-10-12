//testbench for KT8 RAM

`include "ram.v"
module ram_tb();
   reg clk, we;
   reg [3:0] address;
   reg [7:0] ram_in;
   wire [7:0] ram_out;
  

   //instantiate device under test
   ram dut(.clk_i (clk), 
           .address_i (address), 
           .in_i (ram_in), 
           .out_o (ram_out),
           .we_i (we) );

   initial $readmemh("ramtest.txt", dut.mem);

   initial begin
     $monitor ("clk=%b,Address=%b,ram_in=%b,ram_out=%b,WE=%b", clk, address, ram_in, ram_out, we);
				
     #5 clk=0; address=1; ram_in=10; we=0;
     #5 we=1;
     #5 clk=1;
     #5 we=0;
   end
endmodule
