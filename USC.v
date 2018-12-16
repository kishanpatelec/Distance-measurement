`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Kishankumar Patel
// 
// Create Date:    18:35:04 10/15/2018 
// Design Name: 
// Module Name: USC(Ultrasonic Sensor Controller) 
// Project Name: Distance_measurement_UltrasonicSensor	
// Target Devices: WAXWING SPARTAN 6 BOARD
// Tool versions: Xilinx ISE Design Suit
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module USC(echo,trigger,ss,en,clk);
input clk,echo;		//for clk, echo pins of ultrasonic sensor
output reg trigger;	//for trigger pin of ultrasonic sensor
output [7:0] ss;	//Seven-segment (abcdefg)display
output [2:0] en;	//3 bit for enable the 3-digit seven-segs
reg [9:0] distance;	//On 3-digit seven-segs maximum distance is 999, so equivalent 10 bits to display upto 1024
reg nclk;	//new clock 	
reg [31:0] t_2c, t_3c, on_count, off_count, t_c, count;	
initial begin
	trigger=1;
	count=0;
	t_c=0;
	t_2c=0;
	t_3c=0;
	on_count=1002;
	off_count=10000000;
end
sss m1(clk,distance,en,ss);
always @(posedge clk) begin
	if(trigger==1) begin
		count=count+1;
		if(count==on_count) begin
			count=0;
			trigger=0;
	   end
	end	
	else begin
		count=count+1;
		if(count==off_count) begin
			count=0;
			trigger=1;
	   end
	end	
end
	
	always
		distance=(t_ccc*34)/200000;
			
always @(posedge clk) begin
		if(echo==0) begin
			t_3c=t_2c+1;
			t_c=0;
		end	
		else if(echo==1)	begin
			t_c=t_c+1;
			t_2c=t_c;
		end
end		
endmodule		

		
