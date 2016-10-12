
//testbench for program counter.
`include "pc.v"
module pc_tb();
   reg        clk, rst, jump_up, jump_down;
   reg [3:0]  jump_distance;
   wire [7:0] pc_out;
  

   //instantiate device under test
   pc dut(.clk_i (clk), 
          .rst_i (rst), 
          .jump_up_i (jump_up), 
          .jump_down_i (jump_down), 
          .jump_distance_i (jump_distance),
          .count_o (pc_out) );

   initial begin
     $monitor ("clk=%b,rst=%b,jump_up=%b,jump_down=%b,jump_dist=%b,out=%b", 
	            clk, rst, jump_up, jump_down, jump_distance, pc_out);
				
     #5 clk=0; rst=1; jump_up=0; jump_down=0; jump_distance=0;
     //come out of reset and clock twice
     $display("Try increment");
     #5 rst=0; #5 clk=1; #5 clk=0; #5 clk=1; #5 clk=0; 
     if (pc_out!=2) $error("Failed Increment");
     $display("Try jump up");
     #5 jump_distance=5; jump_up=1; 
     #5 clk=1; #5 clk=0; 
     if(pc_out!=7) $error("Failed Jump Up");
     $display("Try jump down");
     #5 jump_up=0; jump_down=1; jump_distance=6; 
     #5 clk=1; #5 clk=0; 
     if( pc_out!=1) $error("Failed Jump Down");
     $display("Try reset");
     #5 rst=1; 
     #5 clk=1;  #5 clk=0;  #5 clk=1;  #5 clk=0; 
     if(pc_out!=0) $error("Failed Reset Hold");
   end
endmodule
