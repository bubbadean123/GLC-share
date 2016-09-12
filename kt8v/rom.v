module rom(Address, out);

  input [7:0] Address;
  output [7:0] out;  

  reg [7:0] mem [0:255];
    
  assign out=mem[Address];

endmodule

module rom_tb();
   reg [7:0] Address=0;
   wire [7:0] out;
  

   //instantiate device under test
   rom dut(Address, out);

   initial begin
     $monitor ("Address=%b,out=%b", Address, out);
				
	
   end
endmodule
