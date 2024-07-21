`timescale 1ns / 1ps

module mean_controller(clock,sel,load,reset,mem_scan_done);

input clock;
output reg [5:0] sel;
output reg [2:0] load;
output reg reset;
input mem_scan_done;

reg [1:0] state; 

always @(posedge clock)
begin
    case(state)
        
        2'b00: begin
                sel[0] <= 0; sel[1]<=0;  sel[2]<=0; sel[3]<=0; sel[5]<=0;
                load[0] <=0; load[1]<=1; load[2]<=1; reset <= 0 ;
                state <= 2'b01;
                end 
        2'b01: begin
                if(mem_scan_done)
                    begin
                    state <= 2'b11;
                    end
                else
                state <= 2'b10;
                end
        2'b10: begin
                sel[0] <= 1; sel[1]<=1;  sel[2]<=1; sel[4]<=0; sel[3]<=1; sel[5]<=0;
                load[0] <=0; load[1]<=1; load[2]<=1;
                state <= 2'b01;
                end
        2'b11: begin
                reset <= 1;
                load[0] <= 1; 
                sel[5] <= 1;
                state <= 2'b11;
                end
    endcase
end

endmodule
