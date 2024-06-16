`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 02:39:37 PM
// Design Name: 
// Module Name: counter
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

module counter(input oneHz,
               input twoHz,
               input RESET,
               input paused,
               input [2:0] state,
               output reg [3:0] ones,
               output reg [3:0] tens,
               output reg [3:0] hundreds,
               output reg [3:0] thousands
);

    parameter normal = 3'd0;
    parameter adj_m = 3'd1;
    parameter adj_s = 3'd2;
    
    // changing clock based on state
    reg temp_clk;
    always @(*) begin
        case(state)
            adj_m, adj_s: temp_clk = twoHz;
            default: temp_clk = oneHz;
        endcase
    end
    
    always @(posedge temp_clk or posedge RESET) begin
        if (RESET) begin
            ones <= 0;
            tens <= 0;
            hundreds <= 0;
            thousands <= 0;
        end
        else if (paused) begin
            ones <= ones;
            tens <= tens;
            hundreds <= hundreds;
            thousands <= thousands;
        end
        else if (state == normal) begin
            if(ones == 9) begin
                ones <= 0;
                if(tens == 5) begin
                     tens <= 0;
                     if(hundreds == 9) begin
                        hundreds <= 0;
                        if(thousands == 5) begin
                            thousands <= 0;
                        end
                        else begin
                            thousands <= thousands + 1;
                        end
                     end
                     else begin
                        hundreds <= hundreds + 1;
                     end
                end
                else begin
                    tens <= tens + 1;
                end
            end
            else begin
                ones <= ones + 1;
            end
        end
        else if(state == adj_m) begin
            // minutes should blink
            if(hundreds == 9) begin
                hundreds <= 0;
                if(thousands == 5) begin
                    thousands <= 0;
                end
                else begin
                    thousands <= thousands + 1;
                end
             end
             else begin
                hundreds <= hundreds + 1;
             end
        end
        else if(state == adj_s) begin
            // seconds should blink
            if(ones == 9) begin
                ones <= 0;
                if(tens == 5) begin
                     tens <= 0;
                end
                else begin
                    tens <= tens + 1;
                end
            end
            else begin
                ones <= ones + 1;
            end
        end
    end
    
endmodule
