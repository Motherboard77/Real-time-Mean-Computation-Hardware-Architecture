`timescale 1ns / 1ps

module memory_controller(clock,reset,data_out,scan_done);

//houses the memory and the 5-bit register

input clock;
input reset;
output reg [15:0] data_out;
output reg scan_done;

reg [15:0] mem_block[0:15];
reg [3:0] mem_pointer;

reg [3:0] count;
integer i;

initial
begin
$readmemb ("mem_store.txt", mem_block);
mem_pointer = mem_block[15];
end

always @(posedge clock)
begin
    if(reset)
    begin  
    for(i=0;i<=15;i=1+1)
    mem_block[i] <= 0;
    
    mem_pointer = mem_block[15];
    count = 4'b0000;
    end
    else
    if(count < mem_pointer)
    begin
    data_out <= mem_block[count] ;
    count = count +1;
    end
end

always @(count)
begin
if(count == mem_pointer-1)
scan_done <= 1;     //when scan_done == 1, reset signal will be activated by the controller
else
scan_done <= 0;
end
endmodule
