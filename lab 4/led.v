`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2024 02:23:01 PM
// Design Name: 
// Module Name: led
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


module led(input oneHz,
           input RESET,
           input playing,
           output reg [15:0] led
);

reg [3:0] random;

always @(posedge oneHz or posedge RESET) begin
    if (RESET) begin
        random <= 4'd1;
        led <= 16'b0;
    end
    else if (playing) begin
        random <= {random[2:0], random[3] ^ random[2]};
        led <= 16'b1 << random;
    end
end

endmodule
