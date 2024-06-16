`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 03:48:29 PM
// Design Name: 
// Module Name: rounding
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


module rounding(input [2:0] exponent,
                input [3:0] significand,
                input fifthBit,
                output reg [2:0] finalExponent,
                output reg [3:0] finalSignificand
);

always @(*) begin
    if (fifthBit == 1) begin
        if (significand == 4'b1111) begin
            finalSignificand <= (significand >> 1) + 1;
            finalExponent <= exponent + 1;        
        end
        else begin
            finalSignificand <= significand + 1'b1;
            finalExponent <= exponent;
        end
    end
    else begin
        finalSignificand <= significand;
        finalExponent <= exponent;
    end
end

endmodule
