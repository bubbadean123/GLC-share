// Program Counter for kt8
// CAK 2016
// 8 bit counter with reset. Can also jump up or down
// 0-16 counts.

module program_counter(clk, rst, jump_up, jump_down, jump_distance, out);
  input clk, rst, jump_up, jump_down;
  input [3:0] jump_distance;
  output [7:0] out;
  reg [7:0] out;
					   
  always @(posedge clk, posedge rst)
    if (rst) out<=0;
    else if (jump_up) out<=out+jump_distance;
    else if (jump_down) out<=out-jump_distance;
    else out<=out+1;

endmodule

//testbench for program counter.
module program_counter_tb();
   reg        clk, rst, jump_up, jump_down;
   reg [3:0]  jump_distance;
   wire [7:0] out;
  

   //instantiate device under test
   program_counter dut(clk, rst, jump_up, jump_down, jump_distance, out );

   initial begin
     $monitor ("clk=%b,rst=%b,jump_up=%b,jump_down=%b,jump_dist=%b,out=%b", 
	            clk, rst, jump_up, jump_down, jump_distance, out);
     $dumpfile("pc.dump");
     $dumpvars();
     #5 clk=0; rst=1; jump_up=0; jump_down=0; jump_distance=0;
     //come out of reset and clock twice
     $display("Try increment");
     #5 rst=0; #5 clk=1; #5 clk=0; #5 clk=1; #5 clk=0; 
     if (out!=2) $error("Failed Increment");
     $display("Try jump up");
     #5 jump_distance=5; jump_up=1; 
     #5 clk=1; #5 clk=0; 
     if(out!=7) $error("Failed Jump Up");
     $display("Try jump down");
     #5 jump_up=0; jump_down=1; jump_distance=6; 
     #5 clk=1; #5 clk=0; 
     if( out!=1) $error("Failed Jump Down");
     $display("Try reset");
     #5 rst=1; 
     #5 clk=1;  #5 clk=0;  #5 clk=1;  #5 clk=0; 
     if(out!=0) $error("Failed Reset Hold");
   end
endmodule
