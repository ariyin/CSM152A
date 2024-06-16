`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 02:39:37 PM
// Design Name: 
// Module Name: stopwatch
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

module stopwatch(input clk,
                 input RESET,
                 input PAUSE,
                 input ADJ,
                 input SEL,
                 output [0:6] seg,
                 output [3:0] an
);
    
    wire w_twoHz, w_oneHz, w_fast, w_blink, PAUSE_valid, RESET_valid;
    wire [3:0] w_1s, w_10s, w_100s, w_1000s;
    
    clock clockinst(.clk(clk), .RESET(RESET), .twoHz(w_twoHz), .oneHz(w_oneHz), .fast(w_fast), .blink(w_blink));
    
    // debouncing
    debouncer p_deb(.clk(clk), .sig_in(PAUSE), .btn_valid(PAUSE_valid));
    debouncer r_deb(.clk(clk), .sig_in(RESET), .btn_valid(RESET_valid));
    
    parameter normal = 3'd0;
    parameter adj_m = 3'd1;
    parameter adj_s = 3'd2;
    reg [2:0] state;
    
    // determining state
    always @(*) begin
        if(ADJ & ~SEL) begin
            state = adj_m;
        end
        else if(ADJ & SEL) begin
            state = adj_s;
        end
        else if(~ADJ) begin
            state = normal;
        end
    end
    
    // determining paused or not
    reg paused = 0;
    always @(posedge PAUSE_valid) begin
        paused <= ~paused;
    end
    
    counter counts(.oneHz(w_oneHz), .twoHz(w_twoHz), .RESET(RESET_valid), .paused(paused), .state(state), .ones(w_1s), .tens(w_10s), .hundreds(w_100s), .thousands(w_1000s));
    
    segment segc(.clk(clk), .blink(w_blink), .RESET(RESET_valid), .state(state), .ones(w_1s), .tens(w_10s), .hundreds(w_100s), .thousands(w_1000s), .seg(seg), .an(an));

endmodule
