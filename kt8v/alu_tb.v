

//testbench for alu
`include "alu.v"
module alu_tb();
   reg [7:0]  a, b;
   reg [3:0] op;
   wire [7:0] r;
  
   //instantiate device under test
   alu dut(.a_i (a), 
               .b_i (b), 
               .op_i (op),  
               .r_o (r) );

   initial begin
     $monitor ("a=%b,b=%b,op=%b,r=%b", 
	            a, b, op, r);
				
     a=0; b=0; op=0;
     #5 a=3; b=5;
     #5 op=1;

   end
endmodule
