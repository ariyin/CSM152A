`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 02:37:22 PM
// Design Name: 
// Module Name: fpcvt
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

module FPCVT(input [11:0] D, 
             output wire S, 
             output wire [2:0] E,
             output wire [3:0] F
);   

wire [2:0] fp_exponent;
wire [3:0] fp_significand;
wire [10:0] fp_magnitude;
wire fp_fifthBit;

twosComp signMag(.twelveBit(D), .sign(S), .magnitude(fp_magnitude));
binToFP floatingPoint(.magnitude(fp_magnitude), .exponent(fp_exponent), .significand(fp_significand), .fifthBit(fp_fifthBit));
rounding rounded(.exponent(fp_exponent), .significand(fp_significand), .fifthBit(fp_fifthBit), .finalExponent(E), .finalSignificand(F));
                    
endmodule
