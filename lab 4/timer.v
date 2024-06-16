`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 03:48:25 PM
// Design Name: 
// Module Name: timer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module timer(input clk,
             input RESET,
             output reg [3:0] hundreds,
             output reg [3:0] thousands,
             output reg playing
);

always @(posedge clk or posedge RESET) begin
    if (RESET) begin
        hundreds <= 0;
        thousands <= 2;
        playing <= 1;
    end
    else if (playing) begin
        if (hundreds == 0 && thousands == 0) begin
            hundreds <= 0;
            thousands <= 0;
            playing <= 0;
        end
        else if (hundreds == 0 && thousands > 0) begin
            hundreds <= 9;
            thousands <= thousands - 1;
        end
        else begin
            hundreds <= hundreds - 1;
        end
    end
    else begin // default state (not playing yet)
        hundreds <= 0;
        thousands <= 0;
        playing <= 0;
    end
end

endmodule
