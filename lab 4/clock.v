`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2024 02:54:55 PM
// Design Name: 
// Module Name: clock
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


module clock(input clk,
             input RESET,
             output reg oneHz
);
  
    // 1 Hz
    reg [25:0] count_1 = 0;
    parameter dv_1 = 26'd50_000_000;
    
    // 100MHz -> oneHz
    always @(posedge clk, posedge RESET) begin
        if (RESET) begin
            count_1 <= 0;
            oneHz <= 0;
        end
        else if (count_1 == dv_1 - 1) begin
            count_1 <= 0;
            oneHz <= ~oneHz;
        end
        else begin
            count_1 <= count_1 + 1;
            oneHz <= oneHz;
        end
    end

endmodule
