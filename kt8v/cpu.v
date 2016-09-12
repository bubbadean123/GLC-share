module kt8_cpu(clk, rst, instruction, ram_in, code_address, data_address, ram_out, write, kd_reset);
  input clk, rst;
  input [7:0] instruction;
  input [7:0] ram_in;
  output [7:0] code_address;
  output [7:0] data_address;
  output [7:0] ram_out;
  output write, kd_reset;

  //internal_signals
  wire r_zero;
  //decoder numeric output, reg value, jump distance, or ALU op code
  reg [7:0] ivalue; 
  wire [7:0] b_input;
  reg load_a, load_b, load_r, jump_up, jump_down, b_immediate;
  reg [7:0] alu_out
  
  program_counter PC(clk, rst, jump_up, jump_down, ivalue[3:0], code_address);
  instruction_decoder(instruction, r_zero, load_a, load_b, load_r, jump_up, jump_dowm, b_immediate, ivalue );
  //registers
  register A(clk, rst, load_a, ram_in, a_out); //A reg always fed from RAM
  register B(clk, rst, load_b, b_input, b_out); 
  register R(clk, rst, load_r, alu_out, ram_out);

  alu ALU(a_out, b_out, ivalue[3:0], alu_out);

  //select input for register B, could be immediate value or from RAM
  assign b_input = (b_immediate) ? ivalue : ram_in;

  //zero test
  assign r_zero = (ram_out == 0);


endmodule
               
