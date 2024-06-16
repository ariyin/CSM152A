`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 02:47:03 PM
// Design Name: 
// Module Name: twosComp
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


module twosComp(
    input [11:0] twelveBit,
    output reg sign,      
    output reg [10:0] magnitude
);

reg [11:0] tBit;

always @(*) begin
    sign = twelveBit[11];
    if (sign == 1'b1) begin
        // use two's complement: invert all bits then add 1
        tBit <= ~twelveBit + 1'b1;
    end
    else begin
        // if positive, stays the same
        tBit <= twelveBit;
    end
    // edge case
    if (tBit >= 1920) begin
        magnitude <= 1920;
    end
    else begin
        magnitude <= tBit[10:0];
    end
    
end

endmodule

