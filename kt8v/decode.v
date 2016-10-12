//KT8 instruction decoder
//Lots of random logic to do the correct thing for each instruction

module decode(instruction_i,
             r_value_i,
             jump_up_o,
             jump_down_o,
             jump_distance_o,  
             b_value_o, 
             b_current_i,
             load_a_o,
             load_b_o,
             load_r_o,
             ram_wr_o, 
             ram_data_i );
  input [7:0] instruction_i, r_value_i, ram_data_i, b_current_i;
  output [7:0] b_value_o;
  output [3:0] jump_distance_o;
  output jump_up_o, jump_down_o;
  output load_a_o, load_b_o, load_r_o;
  output ram_wr_o;

  reg jump_up_o, jump_down_o;
  reg [3:0] jump_distance_o;

  //program counter control
  always @(*)
    if instruction_i[7:4] == b'1100 begin
      //FJMP
      jump_up_o = 1;  
      jump_down_o = 0;
      jump_distance_o = instruction_i[3:0];
   end else if instruction_i[7:4] == b'1101 begin
      //BJMP
      jump_up_o = 0;
      jump_down_o = 1;
      jump_distance_o = instruction_i[3:0];
   end else if (instruction_i == h'E0) && (r_value_i == 0) begin
      //SKIPZ and R==0, so skip
      jump_up_o = 1;
      jump_down_o = 0;
      jump_distance_o = 2;
   end else if (instruction_i == h'E1) && (r_value_i != 0) begin
      //SKIPNZ and R!=0, so skip
      jump_up_o = 1;
      jump_down_o = 0;
      jump_distance_o = 2;
   end else begin
      //normal count up
      jump_up_o = 0;
      jump_down_o = 0;
      jump_distance_o = 0;
   end
 
  

