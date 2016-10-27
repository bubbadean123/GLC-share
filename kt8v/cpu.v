//The KT8 CPU core, not including program memory or RAM

`include "pc.v"
`include "datareg.v"
`include "alu.v"
`include "program_control.v"
`include "data_control.v"
module cpu(clk_i,
           rst_i,
	   p_address_o,
           p_data_i,
           ram_address_o,
           ram_data_i,
	   ram_data_o,
	   ram_we_o );
  input clk_i, rst_i;
  input [7:0] p_data_i;
  input [7:0] ram_data_i;
  output [7:0] p_address_o;
  output [4:0] ram_address_o;
  output [7:0] ram_data_o;
  output ram_we_o;

  //CPU internal buses and signals
  wire jump_up, jump_down, load_a, load_b, load_r, pcrst, rst, hlt;
  wire [3:0] jump_distance;
  wire [7:0] a_out, b_in, b_out, r_in;

  //registers
  datareg A(.clk_i (clk),
            .rst_i (rst_i),
            .en_i (load_a),
            .in_i (ram_data_i), //A reg always loaded from RAM
            .out_o (a_out) );
  datareg B(.clk_i (clk),
            .rst_i (rst_i),
            .en_i (load_b),
            .in_i (b_in),
            .out_o (b_out) );
  datareg R(.clk_i (clk),
            .rst_i (rst_i),
            .en_i (load_r),
            .in_i (r_in),
            .out_o (ram_data_o) ); //R reg outputs direct to RAM

  //program counter
  pc PC(.clk_i (clk), 
        .rst_i (pcrst), 
        .jump_up_i (jump_up), 
        .jump_down_i (jump_down), 
        .jump_distance_i (jump_distance), 
        .count_o (p_address_o) );

  //ALU, calcs based on A and B, results go to R
  //opcode is always low 4 bits of instruction
  alu ALU(.a_i (a_out),
          .b_i (b_out),
          .op_i (p_data_i[3:0]),
          .r_o (r_in) );

  // contains all the combinatorial logic to control registers, RAM and PC based
  // on current instruction
  program_control PCTRL (.instruction_i (p_data_i), //the current instruction
                         .r_value_i (ram_data_o), //needed for R=0 test
                         .rst_i (rst_i),
                         .jump_up_o (jump_up),  //control of PC
                         .jump_down_o (jump_down),
                         .jump_distance_o (jump_distance),
                         .rst_o (rst), 
                         .hlt_o (hlt) );
  data_control DCTRL (.instruction_i (p_data_i), //the current instruction  
                      .b_value_o (b_in), //B can be ORd with imediate
                      .b_current_i (b_out),
                      .load_a_o (load_a),  //controls loading of registers
                      .load_b_o (load_b),
                      .load_r_o (load_r),
                      .ram_wr_o (ram_we_o), //also control RAM write
                      .ram_data_i (ram_data_i) );
             
  //RAM address is always lower 5 bits of instruction (for valid instructions)
  assign ram_address_o = p_data_i[4:0];
  assign pcrst = rst_i || rst;
  assign clk = ~hlt && clk_i;
endmodule
               
