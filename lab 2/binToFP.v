`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2024 02:38:39 PM
// Design Name: 
// Module Name: binToFP
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


module binToFP(
    input [10:0] magnitude,
    output reg [2:0] exponent,
    output reg [3:0] significand,
    output reg fifthBit
);

reg [10:0] temp;
reg [3:0] leadingZeros;

always @(*) begin
    // determine the position of the first '1'
    temp = magnitude;
    leadingZeros = 4'b0001;
    if (temp != 0) begin
        while (temp[10] == 0) begin
            leadingZeros = leadingZeros + 1'b1;
            temp = temp << 1;
        end

        // determine the exponent based on the position of the first '1'
        case(leadingZeros)
            3'b001: exponent = 3'b111; // 1 -> 7
            3'b010: exponent = 3'b110; // 2 -> 6
            3'b011: exponent = 3'b101; // 3 -> 5
            3'b100: exponent = 3'b100; // 4 -> 4
            3'b101: exponent = 3'b011; // 5 -> 3
            3'b110: exponent = 3'b010; // 6 -> 2
            3'b111: exponent = 3'b001; // 7 -> 1
            default: exponent = 3'b000; // 8+ -> 0
        endcase

        // significand: 4 bits immediately following the last leading zero or 4 least significant bits
        if (exponent == 3'b000) begin
        	significand = magnitude[3:0];
            fifthBit = 1'b0;
        end
        else begin
            significand = temp[10:7];
            fifthBit = temp[6];
        end
    end
    else begin
        exponent = 2'b00;
        significand = 3'b000;
        fifthBit = 1'b0;
    end
end

endmodule