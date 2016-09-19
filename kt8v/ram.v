module ram(clk, Address, in, out, WE, CS);

  input clk, WE, CS;
  input [3:0] Address;
  input [7:0] in;
  output [7:0] out;  

  reg [7:0] mem [0:15];
  
  always @(posedge clk)
    if (WE && CS) mem[Address]=in;
    
  assign out=CS ? mem[Address]: 8'bzzzzzzzz;

endmodule

module ram_tb();
   reg clk=0, WE=0, CS=1;
   reg [3:0] Address=0;
   reg [7:0] in=0;
   wire [7:0] out;
  

   //instantiate device under test
   ram dut(clk, Address, in, out, WE, CS);

   initial begin
     $monitor ("clk=%b,Address=%b,in=%b,out=%b,WE=%b,CS=%b",clk, Address, in, out, WE, CS);
	  $dumpfile("ram.dump");
     $dumpvars();
		
     #1 in=10; WE=1;
     #1 clk=1;
	 #1 WE=0; in=0;
     #1 if (out!=10) $error("Failed Store"); 
     else $display("Successful Store");
     #1 CS=0;
     #1 CS=1;
   end
endmodule
