//KT8 with RAM and testbench code

`include "cpu.v"
`include "ram.v"
`include "rom.v"

module kt8();
  reg clk;
  reg rst;
  wire [7:0] rom_address;
  wire [7:0] rom_data;
  wire [4:0] ram_address; //includes mapped I/O
  wire [7:0] ram_out;
  wire [7:0] ram_in;
  wire ram_we;

  cpu kt8_cpu(.clk_i (clk),
              .rst_i (rst),
              .p_address_o (rom_address),
              .p_data_i (rom_data),
              .ram_address_o (ram_address),
             .ram_data_i (ram_out),
              .ram_data_o (ram_in),
              .ram_we_o (ram_we) );

  //program memory 256 bytes
  rom progmem(.address_i (rom_address),
              .out_o (rom_data) );

  //actual RAM is first 16 bytes of data address space
  //needs a mux or enable to handle high 16 bytes
  ram datamem(.clk_i (clk),
              .address_i (ram_address[3:0]),
              .in_i (ram_in),
              .out_o (ram_out),
              .we_i (ram_we) );

  //testbench, load a program into ROM and cycle the clock

  initial begin
     $readmemb("ram.txt", datamem.mem);
     $readmemb("fib.txt", progmem.mem);

     $dumpfile("kt8.dump");
     $dumpvars();
     rst=1; clk=0;
     #5 rst=0;
     $monitor ("PC=%h,I=%b,A=%h,B=%h,R=%h,ram[0]=%h,ram[1]=%h,rst=%h", 
	             rom_address,
               rom_data,
               kt8_cpu.a_out,
               kt8_cpu.b_out,
               ram_in,
               datamem.mem[0],
               datamem.mem[1],
               rst );
     while (kt8_cpu.hlt == 0) begin
      #5 clk=1;
      #5 clk=0;
     end
  end

endmodule

