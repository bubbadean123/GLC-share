module alu(a_i,
           b_i,
           op_i,
           r_o );
  input [7:0] a_i, b_i;
  input [3:0] op_i;
  output [7:0] r_o;

  reg [7:0] r_o;
					   
  always @(*)
    case (op_i)
      0: r_o=a_i+b_i;
      1: r_o=a_i-b_i;
      2: r_o=a_i&b_i;
      3: r_o=a_i|b_i;
      4: r_o=a_i^b_i;
      5: r_o=~a_i;
      6: r_o=~b_i;
      7: r_o=a_i;
      8: r_o=b_i;
      9: r_o=a_i<<1;
     10: r_o=a_i>>1;
     11: r_o=0;
     12: r_o=a_i+1;
     13: r_o=a_i-1;
     default: r_o=0;
   endcase
endmodule

