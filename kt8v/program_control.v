//KT8 instruction logic
//handles control of program counter based on instructions

module program_control(instruction_i,
                       r_value_i,
                       jump_up_o,
                       jump_down_o,
                       jump_distance_o,
                       rst_o );
  input [7:0] instruction_i;
  input [7:0] r_value_i;
  output reg [3:0] jump_distance_o;
  output reg jump_up_o, jump_down_o, rst_o;


  //program counter control
  always @(*) begin

    if (instruction_i[7:4] == 4'b1100) begin
      //FJMP
      jump_up_o = 1;  
      jump_down_o = 0;
      jump_distance_o = instruction_i[3:0];
   end else if (instruction_i[7:4] == 4'b1101) begin
      //BJMP
      jump_up_o = 0;
      jump_down_o = 1;
      jump_distance_o = instruction_i[3:0];
   end else if (instruction_i == 8'hF0) begin
      // RESET
      rst_o = 1;
      #5 rst_o = 0;
   end else if ((instruction_i == 8'hE0) && (r_value_i == 0)) begin
      //SKIPZ and R==0, so skip
      jump_up_o = 1;
      jump_down_o = 0;
      jump_distance_o = 2;
   end else if ((instruction_i == 8'hE1) && (r_value_i != 0)) begin
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
  end
 
 endmodule

