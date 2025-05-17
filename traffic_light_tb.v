`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2025 16:42:39
// Design Name: 
// Module Name: traffic_light_tb
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



module traffic_light_tb;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [2:0] ns_light;
    wire [2:0] ew_light;

    // Instantiate the Unit Under Test (UUT)
    traffic_light_controller uut (
        .clk(clk),
        .rst(rst),
        .ns_light(ns_light),
        .ew_light(ew_light)
    );

    // Clock generation: 1 Hz (1s period)
    initial begin
     $dumpfile("traffic_light.vcd");
        $dumpvars(0, traffic_light_tb);

        clk = 0;
        forever #500000000 clk = ~clk; // Toggle every 0.5s
    end

    // Stimulus
    initial begin
        rst = 1;
        #1000000000; // Hold reset for 1 second
        rst = 0;

        // Simulate for 100 seconds using 1-second steps
        repeat (100) #1000000000;

        $finish;
    end

endmodule

