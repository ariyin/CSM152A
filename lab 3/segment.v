`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 02:39:37 PM
// Design Name: 
// Module Name: segment
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

module segment(
    input clk,
    input blink,
    input RESET,
    input [2:0] state,
    input [3:0] ones,
    input [3:0] tens,
    input [3:0] hundreds,
    input [3:0] thousands,
    output reg [0:6] seg,   // segment pattern 0-9
    output reg [3:0] an     // digit select signals
);

    parameter adj_m = 3'd1;
    parameter adj_s = 3'd2;
    
    // segment patterns
    parameter ZERO  = 7'b000_0001;  // 0
    parameter ONE   = 7'b100_1111;  // 1
    parameter TWO   = 7'b001_0010;  // 2 
    parameter THREE = 7'b000_0110;  // 3
    parameter FOUR  = 7'b100_1100;  // 4
    parameter FIVE  = 7'b010_0100;  // 5
    parameter SIX   = 7'b010_0000;  // 6
    parameter SEVEN = 7'b000_1111;  // 7
    parameter EIGHT = 7'b000_0000;  // 8
    parameter NINE  = 7'b000_0100;  // 9
    
    // to select each digit in turn
    reg [1:0] select;     // for each of 4 digits
    reg [16:0] timer;     // counter for digit refresh
    
    // controlling digit select and digit timer
    always @(posedge clk or posedge RESET) begin
        if(RESET) begin
            select <= 0;
            timer <= 0;
        end
        else begin  // 4 ms refresh
            if(timer == 99_999) begin
                timer <= 0;
                select <=  select + 1;
            end
            else begin
                timer <=  timer + 1;
            end
        end
    end
    
    // determining anode based on selected digit
    always @(select) begin
        case(select) 
            2'b00 : an = 4'b1110;   // ones
            2'b01 : an = 4'b1101;   // tens
            2'b10 : an = 4'b1011;   // hundreds
            2'b11 : an = 4'b0111;   // thousands
        endcase
        // blinking 
        if (state == adj_m && blink) begin
            // minutes (thousands and hundreds)
            if (select == 2'b10 || select == 2'b11)
                an = 4'b1111;
        end
        else if (state == adj_s && blink) begin
            // seconds (tens and ones)
            if (select == 2'b00 || select == 2'b01)
                an = 4'b1111; 
        end
    end
    
    // determining segments based on selected digit and digit value
    always @* begin
        case(select)
            2'b00 : begin
                case(ones)
                    4'b0000 : seg = ZERO;
                    4'b0001 : seg = ONE;
                    4'b0010 : seg = TWO;
                    4'b0011 : seg = THREE;
                    4'b0100 : seg = FOUR;
                    4'b0101 : seg = FIVE;
                    4'b0110 : seg = SIX;
                    4'b0111 : seg = SEVEN;
                    4'b1000 : seg = EIGHT;
                    4'b1001 : seg = NINE;
                endcase
            end
                    
            2'b01 : begin
                case(tens)
                    4'b0000 : seg = ZERO;
                    4'b0001 : seg = ONE;
                    4'b0010 : seg = TWO;
                    4'b0011 : seg = THREE;
                    4'b0100 : seg = FOUR;
                    4'b0101 : seg = FIVE;
                    4'b0110 : seg = SIX;
                    4'b0111 : seg = SEVEN;
                    4'b1000 : seg = EIGHT;
                    4'b1001 : seg = NINE;
                endcase
            end
                    
            2'b10 : begin
                case(hundreds)
                    4'b0000 : seg = ZERO;
                    4'b0001 : seg = ONE;
                    4'b0010 : seg = TWO;
                    4'b0011 : seg = THREE;
                    4'b0100 : seg = FOUR;
                    4'b0101 : seg = FIVE;
                    4'b0110 : seg = SIX;
                    4'b0111 : seg = SEVEN;
                    4'b1000 : seg = EIGHT;
                    4'b1001 : seg = NINE;
                endcase
            end
                    
            2'b11 : begin
                case(thousands)
                    4'b0000 : seg = ZERO;
                    4'b0001 : seg = ONE;
                    4'b0010 : seg = TWO;
                    4'b0011 : seg = THREE;
                    4'b0100 : seg = FOUR;
                    4'b0101 : seg = FIVE;
                    4'b0110 : seg = SIX;
                    4'b0111 : seg = SEVEN;
                    4'b1000 : seg = EIGHT;
                    4'b1001 : seg = NINE;
                endcase
            end
        endcase
    end
        
endmodule