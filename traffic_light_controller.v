`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2025 16:39:12
// Design Name: 
// Module Name: traffic_light_controller
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


module traffic_light_controller (
    input wire clk,            // Clock input
    input wire rst,            // Synchronous reset
    output reg [2:0] ns_light, // NS light: Green=001, Yellow=010, Red=100
    output reg [2:0] ew_light  // EW light: Green=001, Yellow=010, Red=100
);

    // State encoding using localparams
    localparam NS_GREEN_EW_RED  = 2'b00;
    localparam NS_YELLOW_EW_RED = 2'b01;
    localparam EW_GREEN_NS_RED  = 2'b10;
    localparam EW_YELLOW_NS_RED = 2'b11;

    // Parameters for timing (assuming 1 Hz clock)
    localparam GREEN_TIME  = 6'd30;  // 30 seconds
    localparam YELLOW_TIME = 6'd5;   // 5 seconds

    // Registers
    reg [1:0] current_state, next_state;
    reg [5:0] timer;

    // State and timer update logic
    always @(posedge clk) begin
        if (rst) begin
            current_state <= NS_GREEN_EW_RED;
            timer <= GREEN_TIME;
        end else begin
            if (timer == 0) begin
                current_state <= next_state;
                timer <= (next_state == NS_GREEN_EW_RED || next_state == EW_GREEN_NS_RED) ? GREEN_TIME : YELLOW_TIME;
            end else begin
                timer <= timer - 1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            NS_GREEN_EW_RED:   next_state = NS_YELLOW_EW_RED;
            NS_YELLOW_EW_RED:  next_state = EW_GREEN_NS_RED;
            EW_GREEN_NS_RED:   next_state = EW_YELLOW_NS_RED;
            EW_YELLOW_NS_RED:  next_state = NS_GREEN_EW_RED;
            default:           next_state = NS_GREEN_EW_RED;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            NS_GREEN_EW_RED: begin
                ns_light = 3'b001; // Green
                ew_light = 3'b100; // Red
            end
            NS_YELLOW_EW_RED: begin
                ns_light = 3'b010; // Yellow
                ew_light = 3'b100; // Red
            end
            EW_GREEN_NS_RED: begin
                ns_light = 3'b100; // Red
                ew_light = 3'b001; // Green
            end
            EW_YELLOW_NS_RED: begin
                ns_light = 3'b100; // Red
                ew_light = 3'b010; // Yellow
            end
            default: begin
                ns_light = 3'b100; // Red
                ew_light = 3'b100; // Red
            end
        endcase
    end

endmodule

