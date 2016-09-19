module register(clk, reset, en, in, out);

   input en, clk, reset;
   input [7:0] in;
   output [7:0] out;
   reg [7:0] value=0;

   always @(posedge clk, posedge reset)
     if (reset) value=0;
     else if (en) value=in;   
	 
   assign out=value;

endmodule

module register_tb();
   reg clk=0, en=0;
   reg reset=0;
   reg [7:0] in=0;
   wire [7:0] out;

   //instantiate device under test
   register dut(clk, reset, en, in, out);

   initial begin
     $monitor ("clk=%b,reset=%b,en=%b,in=%b,out=%b",clk, reset, en, in, out);
     $dumpfile ("a.dump");
     $dumpvars;				
     #1 in=10; en=1; clk=1;
     #1 in=0; en=0; clk=0;
     #1 if (out!=10) $error("Failed Load"); 
        else $display("Successful Load");
     #1 reset=1;
     #1 if (out!=0) $error("Failed Reset");
        else $display("Succsessful Reset");
   end
endmodule
