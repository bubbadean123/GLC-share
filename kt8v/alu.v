module alu(a,b,r,op);

input [7:0] a,b;
output reg [7:0] r;
input [3:0] op;

always @(a,b,op)
   case(op)
      0:r=a+b;
      1:r=a-b;
      2:r=a&b;
      3:r=a|b;
      4:r=a^b;
      5:r=~a;
      6:r=~b;
      7:r=a;
      8:r=b;
      9:r=a<<1;
      10:r=a>>1;
      11:r=0;
      12:r=a+1;
      13:r=a-1;
      default:r=8'bxxxx_xxxx;
   endcase

endmodule
