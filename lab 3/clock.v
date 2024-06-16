`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 02:39:37 PM
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
             output reg twoHz,
             output reg oneHz,
             output reg fast,
             output reg blink
);
    
    // 2 Hz 
    reg [25:0] count_2 = 0;
    parameter dv_2 = 26'd25_000_000;
    
    // 1 Hz
    reg [25:0] count_1 = 0;
    parameter dv_1 = 26'd50_000_000;
    
    // much faster (50-700 Hz)
    reg [25:0] count_f = 0;
    parameter dv_f = 26'd100_000;
    
    // blinking in adjust mode (> 1 Hz), cannot be 2 Hz
    reg [25:0] count_b = 0;
    parameter dv_b = 26'd40_000_000;
    
    // 100MHz -> twoHz
    always @(posedge clk, posedge RESET) begin
        if (RESET) begin
            count_2 <= 0;
            twoHz <= 0;
        end
        else if (count_2 == dv_2 - 1) begin
            count_2 <= 0;
            twoHz <= ~twoHz;
        end
        else begin
            count_2 <= count_2 + 1;
            twoHz <= twoHz;
        end
    end
    
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
    
    // 100MHz -> fast
    always @(posedge clk, posedge RESET) begin
        if (RESET) begin
            count_f <= 0;
            fast <= 0;
        end
        else if (count_f == dv_f - 1) begin
            count_f <= 0;
            fast <= ~fast;
        end
        else begin
            count_f <= count_f + 1;
            fast <= fast;
        end
    end
    
    // 100MHz -> blink
    always @(posedge clk, posedge RESET) begin
        if (RESET) begin
            count_b <= 0;
            blink <= 0;
        end
        else if (count_b == dv_b - 1) begin
            count_b <= 0;
            blink <= ~blink;
        end
        else begin
            count_b <= count_b + 1;
            blink <= blink;
        end
    end

endmodule