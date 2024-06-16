`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 02:33:19 PM
// Design Name: 
// Module Name: tb
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


module tb;

    reg [11:0] tb_twelveBit;
    wire tb_sign;
    wire [2:0]tb_exponent;
    wire [3:0]tb_significand;
    
    FPCVT mod1(.D(tb_twelveBit), .S(tb_sign), .E(tb_exponent), .F(tb_significand));
    initial begin
        tb_twelveBit <= 12'b011111111111; // 2047
        #10
        tb_twelveBit <= 1921; // 1921
        #10
        tb_twelveBit <= 1920; // 1920
        #10
        tb_twelveBit <= 1919; // 1919
        #10
        tb_twelveBit <= 1918; // 1918
        #10
        tb_twelveBit <= 1854; // 1854
        #10
        tb_twelveBit <= 1792; // 1792
        #10
        tb_twelveBit <= 1793; // 1793
        #10
        tb_twelveBit <= 12'b001111101000; // 1000
        #10
        tb_twelveBit <= 12'b000110100110; // 422
        #10
        tb_twelveBit <= 12'b000001111101; // 125
        #10
        tb_twelveBit <= 12'b000000111000; // 56
        #10
        tb_twelveBit <= 12'b000000101111; // 47
        #10
        tb_twelveBit <= 12'b000000101110; // 46
        #10
        tb_twelveBit <= 12'b000000101101; // 45
        #10
        tb_twelveBit <= 12'b000000101100; // 44
        #10
        tb_twelveBit <= 12'b000000001111; // 15
        #10
        tb_twelveBit <= 12'b000000000001; // 1
        #10
        tb_twelveBit <= 12'b000000000000; // 0
        #10
        tb_twelveBit <= 12'b111111111111; // -1
        #10
        tb_twelveBit <= 12'b111111011000; // -40
        #10
        tb_twelveBit <= 12'b111001011010; // -422
        #10
        tb_twelveBit <= 12'b110000011000; // -1000
        #10        
        tb_twelveBit <= -1792; // -1792
        #10
        tb_twelveBit <= -1793; // -1793
        #10
        tb_twelveBit <= 12'b100011000010; // -1854
        #10
        tb_twelveBit <= -1918; // -1918
        #10
        tb_twelveBit <= -1919; // -1919
        #10
        tb_twelveBit <= -1920; // -1920
        #10
        tb_twelveBit <= -1921; // -1921
        #10
        tb_twelveBit <= 12'b100000001111; // -2033
        #10
        tb_twelveBit <= 12'b100000000010; // -2046
        #10
        tb_twelveBit <= 12'b100000000001; // -2047
        #10
        tb_twelveBit <= 12'b100000000000; // -2048
    end
endmodule