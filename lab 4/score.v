`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 03:37:57 PM
// Design Name: 
// Module Name: score
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


module score(input clk,
             input [15:0] sw,
             input [15:0] led,
             input RESET,
             input playing,
             output reg [3:0] ones,
             output reg [3:0] tens,
);

reg [15:0] prevS; // previous state of switches

always @(posedge clk or posedge RESET) begin
    if (RESET) begin
        ones <= 4'd0;
        tens <= 4'd0;
    end
    else if (playing) begin
        if ((sw & led) != (prevS & led)) begin
            if (ones == 9) begin
                tens <= tens + 1;
                ones <= 4'd0;
            end 
            else begin
                ones <= ones + 1;
            end
        end
    end
    prevS <= sw;
end

endmodule
