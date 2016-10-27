module pc_testbench();
   logic        clk, rst, jump_up, jump_down;
   logic [15:0] pc_out;
   logic [3:0]  jump_distance;

   //instantiate device under test
   program_counter dut(clk, rst, 
                       jump_up, jump_down, jump_distance,
                       pc_out );

   initial begin
     clk=0; rst=1; jump_up=0; jump_down=0;
     jump_distance=0;
     #10;
     //come out of reset and clock twice
     rst=0; #5;
     clk=1; #5; clk=0; #5; clk=1; #5; clk=0; #5;
     assert (pc_out===1) else $error("Failed Increment");
     //try jump up
     jump_distance=5; jump_up=1; #5;
     clk=1; #5; clk=0; #5;
     assert (pc_out===7) else $error("Failed Jump Up");
     //try jump down
     jump_up=0; jump_down=1; jump_distance=6; #5;
     clk=1; #5; clk=0; #5;
     assert( pc_out===1) else $error("Failed Jump Down");
     //hold in reset
     rst=1; #5;
     clk=1; #5; clk=0; #5; clk=1; #5; clk=0; #5;
     assert (pc_out===0) else $error("Failed Reset Hold");
   end
endmodule
