`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 02:55:48 PM
// Design Name: 
// Module Name: whackamole
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


module whackamole(input clk,
                  input [15:0] sw,
                  input RESET,
                  output [15:0] led,
                  output [0:6] seg,
                  output [3:0] an
);

wire w_oneHz, RESET_valid, w_playing;
wire [3:0] w_1s, w_10s, w_100s, w_1000s;

clock clockinst(.clk(clk), .RESET(RESET), .oneHz(w_oneHz));

// debouncing
debouncer p_deb(.clk(clk), .sig_in(RESET), .btn_valid(RESET_valid));

timer timing(.clk(w_oneHz), .RESET(RESET_valid), .hundreds(w_100s), .thousands(w_1000s), .playing(w_playing));
led leding(.oneHz(w_oneHz), .RESET(RESET_valid), .playing(w_playing), .led(led));
score scoring(.clk(w_oneHz), .sw(sw), .led(led), .RESET(RESET_valid), .playing(w_playing), .ones(w_1s), .tens(w_10s));
segment segc(.clk(clk), .RESET(RESET_valid), .ones(w_1s), .tens(w_10s), .hundreds(w_100s), .thousands(w_1000s), .seg(seg), .an(an));

endmodule
