`timescale 1ns / 1ps

module mean_test();

reg [15:0] data_in;
reg [5:0] sel;
reg [2:0] load;
wire [15:0] data_out;
reg clock = 1'b0;

mean_datapath DATAPATH(data_in,sel,load,data_out,clock);

always 
#10 clock <= ~clock;

initial 
begin
//fixed point format : first 10 bits: integer, remaining 6 bits: fraction
data_in <= 16'b0000001111_000000; //15
sel[0] <= 0; sel[1]<=0;  sel[2]<=0; sel[3]<=0; sel[5]<=0;
load[0] <=0; load[1]<=1; load[2]<=1;
#15
data_in <= 16'b0000001100_000000; //12
sel[0] <= 1; sel[1]<=1;  sel[2]<=1; sel[4]<=0; sel[3]<=1; sel[5]<=0;
load[0] <=0; load[1]<=1; load[2]<=1;
#10
data_in <= 16'b0000000010_000000;// 2
sel[0] <= 1; sel[1]<=1;  sel[2]<=1; sel[4]<=0; sel[3]<=1; sel[5]<=0;
load[0] <=0; load[1]<=1; load[2]<=1;
#10
data_in <= 16'b0000001010_000000;// 10
sel[0] <= 1; sel[1]<=1;  sel[2]<=1; sel[4]<=0; sel[3]<=1; sel[5]<=0;
load[0] <=0; load[1]<=1; load[2]<=1;
#10
data_in <= 16'b0000001001_000000; //9
sel[0] <= 0; sel[1]<=0;  sel[2]<=0; sel[3]<=0; sel[5]<=0;
load[0] <=0; load[1]<=1; load[2]<=1;
#15
data_in <= 16'b0000000110_000000; //6
sel[0] <= 1; sel[1]<=1;  sel[2]<=1; sel[4]<=0; sel[3]<=1; sel[5]<=0;
load[0] <=0; load[1]<=1; load[2]<=1;
#10
data_in <= 16'b0000000010_000000;// 2
sel[0] <= 1; sel[1]<=1;  sel[2]<=1; sel[4]<=0; sel[3]<=1; sel[5]<=0;
load[0] <=0; load[1]<=1; load[2]<=1;
#10
data_in <= 16'b0000000011_000000;// 3
sel[0] <= 1; sel[1]<=1;  sel[2]<=1; sel[4]<=0; sel[3]<=1; sel[5]<=0;
load[0] <=0; load[1]<=1; load[2]<=1;
#10
load[0] <= 1; sel[5] <= 1;

end

endmodule
