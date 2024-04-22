`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2024 15:38:13
// Design Name: 
// Module Name: clock_tb
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

module clock_tb;

// Parameters

reg clk;
reg reset;
reg set_alarm;
reg [4:0] alarm_hours;
reg [5:0] alarm_mins;
reg [5:0] alarm_secs;
reg start;
reg set_hours;
reg set_mins;
reg set_secs;

// Outputs
wire [4:0] hours;
wire [5:0] mins;
wire [5:0] secs;
wire buzzer;
// Instantiate the clock module
clock uut (
    .clk(clk),
    .reset(reset),
    .set_alarm(set_alarm),
    .alarm_hours(alarm_hours),
    .alarm_mins(alarm_mins),
    .alarm_secs(alarm_secs),
    .start(start),
    .set_hours(set_hours),
    .set_mins(set_mins),
    .set_secs(set_secs),
    .hours(hours),
    .mins(mins),
    .secs(secs),
    .buzzer(buzzer)
);

// Clock generation
initial clk=0;
  always #10 clk = ~clk; // Generate a clock with a period of 10 time units (100 MHz)


// Initial reset
initial begin
    reset = 1;
    #10;
    reset = 0;
    start=0;
 #100;
  set_alarm = 1;
  #10;
  set_hours=1;
    alarm_hours = 5'b00000;
    #10;
    set_hours=0;
    #20;
    set_mins=1;
    alarm_mins = 6'b000011;
    #10;
    set_mins=0;
    #20;
    set_secs=1;
    alarm_secs = 6'b000010;
    #10;
    set_secs=0;
    #10;
    set_alarm=0;
    start=1;
    #40000000;
 $finish;
    
end
endmodule