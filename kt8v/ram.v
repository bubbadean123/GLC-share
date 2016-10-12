//16 byte RAM used for KT8

module ram (clk_i, 
            address_i, 
            in_i, 
            out_o, 
            we_i);

  input clk_i, we_i;
  input [3:0] address_i;
  input [7:0] in_i;
  output [7:0] out_o;  
  //CK - Changed array to 0-15 from 15-0
  //not sure if it matters, but this seems to be the standard
  reg [7:0] mem [0:15];
  
  always @(posedge clk_i)
    if (we_i) mem[address_i]=in_i;
    
  //output is not clocked, always reflects current memory addresses
  assign out_o=mem[address_i];

endmodule


