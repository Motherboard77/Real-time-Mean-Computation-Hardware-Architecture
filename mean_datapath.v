`timescale 1ns / 1ps

module mean_datapath(data_in,select,load,data_out,clock);

input [15:0] data_in;
input [5:0] select;
input [2:0]load;
input clock;
output [15:0] data_out;  

wire [15:0] w[14:0] ;
wire c_out;

demux_1to2_16bit DEMUX1(data_in,select[0],w[0],w[7]);
mux_2to1_16bit MUX1(w[0],w[6],select[1],w[1]);
demux_1to2_16bit DEMUX2(w[1],select[2],w[2],w[8]);
mux_2to1_16bit MUX2(w[2],w[13],select[3],w[3]);
PIPO REG1(w[3],clock,load[2],w[4]);
demux_1to2_16bit DEMUX3(w[4],select[5],w[6],w[5]);
PIPO REG2(w[5],clock,load[0],data_out);

//SAU UNIT
shifter_1bit SHIFT1(clock,w[8],w[9]);
shifter_1bit SHIFT2(clock,w[7],w[10]);
mux_2to1_16bit MUX3(w[10],1'b0,select[4],w[11]);
ADDER_16BIT ADDER1(w[9],w[11],1'b0,w[12],c_out);

PIPO REG3(w[12],clock,load[1],w[13]);

endmodule



module mux_2to1_16bit(a,b,sel,data_out);


input [15:0] a;
input [15:0] b;
input sel;

output [15:0] data_out;

assign data_out = sel ? b:a;

endmodule



module demux_1to2_16bit(data_in,sel,out0,out1);

input [15:0] data_in;
input sel;
output reg [15:0] out0;
output reg [15:0] out1;

always @(*)
begin
case(sel)
    1'b0: begin
          out0 = data_in;
          out1 = 16'b0;
          end
    1'b1: begin
          out0 = 16'b0;
          out1 = data_in;
          end
endcase
end

endmodule

`timescale 1ns / 1ps

module PIPO(a,clock,load,reg_out);

parameter n = 15;

input [15:0] a;
input clock;
input load;
output reg [n:0] reg_out;

always @(posedge clock)
begin
    if(load)
    reg_out <= a;
end
endmodule

`timescale 1ns / 1ps

module shifter_1bit(clock,data_in,data_out);

input clock;
input [15:0] data_in;
output reg [15:0] data_out;

always@(posedge clock)
begin
data_out = data_in >> 1;   //right shift by 1 bit
end
endmodule

`timescale 1ns / 1ps

module ADDER_16BIT(a,b,c_in,sum,c_out);

input [15:0] a;
input [15:0] b;
input c_in;

output [15:0] sum;
output c_out;

assign {c_out,sum} = a+b+c_in;

endmodule




