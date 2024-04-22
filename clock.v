`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2024 15:34:53
// Design Name: 
// Module Name: clock
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

module clock(
    input  clk,     // Clock input
    input  reset,   // Reset input
    input set_alarm,
    input  [4:0] alarm_hours,   // Input for setting the alarm hours
    input  [5:0] alarm_mins,    // Input for setting the alarm minutes
    input  [5:0] alarm_secs,
    input start,   
    input  set_hours,       // Input to indicate loading hours
    input  set_mins,        // Input to indicate loading minutes
    input  set_secs,   
    output reg buzzer,
    output reg [4:0] hours,   // Output for hours (5 bits)
    output reg [5:0] mins,    // Output for minutes (6 bits)
    output reg [5:0] secs     // Output for seconds (6 bits)
);

// Internal registers to hold the current time
reg [4:0] alarm_hours_reg;
reg [5:0] alarm_mins_reg;
reg [5:0] alarm_secs_reg;

always @(*) begin
    alarm_hours_reg = set_alarm && set_hours? alarm_hours : alarm_hours_reg;
    alarm_mins_reg = set_alarm && set_mins? alarm_mins : alarm_mins_reg;
    alarm_secs_reg = set_alarm && set_secs? (alarm_secs-2'b01) : alarm_secs_reg;
end


// Counter for seconds
always @(posedge clk or posedge reset) begin
    if (reset) begin
        secs <= 6'b000000; 
        mins<=6'b000000;
        hours<=5'b00000;  // Reset seconds to 0
    end 
    else if(start)
    begin
        if (secs == 6'b111011) 
        begin
            secs<= 6'b000000;   // Reset seconds to 0 when it reaches 59
            // Increment minutes when seconds reach 59
            if (mins== 6'b111011) 
            begin
                mins <= 6'b000000;   // Reset minutes to 0 when it reaches 59
                // Increment hours when minutes reach 59
                if (hours== 5'b11001) 
                begin
                    hours<= 5'b00000;   // Reset hours to 0 when it reaches 23
                end 
                else 
                begin
                    hours<= hours+ 1; // Increment hours
                end
            end 
            else 
            begin
                mins<= mins+ 1; // Increment minutes
            end
        end 
        else 
        begin
        if (hours == alarm_hours_reg && mins == alarm_mins_reg && secs == alarm_secs_reg) begin
            buzzer<=1;
            secs<= secs + 1; // Increment seconds
            end
        else begin
        buzzer<=0;
        secs<=secs +1;
        end
        
        
        
        
        end
    end
end

// Assign current time values to outputs
//always @* begin
//    hours = hours_reg;
//    mins = mins_reg;
//    secs = secs_reg;
//end
//always @(posedge clk) begin
//    if (hours == alarm_hours_reg && mins == alarm_mins_reg && secs == alarm_secs_reg) begin
//        buzzer <= 1; // Activate the buzzer
//    end else begin
//        buzzer <= 0; // Deactivate the buzzer
//    end
//end
endmodule


