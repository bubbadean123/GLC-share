//KT8 instruction decoder
//Lots of random logic to do the correct thing for each instruction

module data_control (instruction_i, //the current instruction  
                     b_value_o, //B can be ORd with imediate
                     b_current_i,
                     load_a_o,  //controls loading of registers
                     load_b_o,
                     load_r_o,
                     ram_wr_o, //also control RAM write
                     ram_data_i );
  input [7:0] instruction_i, ram_data_i, b_current_i;
  output reg [7:0] b_value_o;
  output reg load_b_o;
  output wire load_a_o, load_r_o, ram_wr_o;

  reg jump_up_o, jump_down_o;
  reg [3:0] jump_distance_o;

  //I = 010aaaaa : save to memory
  assign ram_wr_o = (instruction_i[7:5] == 3'b010) ? 1 : 0;

  //I=000aaaaa : load RAM to A
  assign load_a_o = (instruction_i[7:5] == 3'b000) ? 1 : 0;

  //I=1000xxxx : ALU op, load R
  assign load_r_o = (instruction_i[7:4] == 4'b1000) ? 1 : 0;
  
  //what to do with register B
  always @(*)
    if (instruction_i[7:4] == 4'b0110) begin
      //LOWBITS

      b_value_o = {b_current_i[7:4], instruction_i[3:0]};
      load_b_o = 1;
   end else if (instruction_i[7:4] == 4'b0111) begin
      //HIGHBITS
      b_value_o = {instruction_i[3:0], b_current_i[3:0]};
      load_b_o = 1;
   end else if (instruction_i[7:5] == 3'b001) begin
      //load B from RAM
      b_value_o = ram_data_i;
      load_b_o = 1;
   end else begin
      //leave B alone
      b_value_o = 0;
      load_b_o = 0;
   end
 
endmodule

