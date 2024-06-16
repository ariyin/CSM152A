`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 02:39:37 PM
// Design Name: 
// Module Name: debouncer
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

module debouncer(input clk,
                 input sig_in,
                 output btn_valid
);

    wire Q1, Q2, Q2_bar;
    Dff d1(clk, sig_in, Q1);
    Dff d2(clk, Q1, Q2);
    
    assign Q2_bar = ~Q2;
    assign btn_valid = Q1 & Q2_bar;

endmodule

module Dff(input clk,
           input  D,
           output reg Q,
           output reg Qbar
);

    always @(posedge clk) begin
        Q <= D;
        Qbar <= !Q;
    end

endmodule
