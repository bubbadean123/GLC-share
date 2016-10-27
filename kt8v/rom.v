//256 byte ROM used for KT8 program memory

module rom (address_i,  
            out_o );

  input [7:0] address_i;
  output [7:0] out_o;  
  reg [7:0] mem [0:255];
  
  //output is not clocked, always reflects current memory addresses
  assign out_o=mem[address_i];

endmodule


