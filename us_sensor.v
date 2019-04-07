`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:35:04 10/15/2018 
// Design Name: 
// Module Name:    kpus 
// Project Name: Distance_measurement_UltrasonicSensor	
// Target Devices: WAXWING SPARTAN 6 BOARD
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module us_sensor(echo,trigger,ss,en,clk);
input clk,echo;
output reg trigger;
output [7:0] ss;
output [2:0] en;
reg [9:0] distance;	
reg nclk;	
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
sev_seg m1(clk,distance,en,ss);
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
		distance=(t_3c*34)/200000;
			
always @(posedge clk) begin
		if(echo==0) begin
			t_3c=t_2c+1;					//total pulses for echo=1
			t_c=0;							//make this counting variable 0 for next time counting purpose
		end	
		else if(echo==1)	begin
			t_c=t_c+1;						//count pulses for echo =1 (time during echo = 1, is propotional to distance)  
			t_2c=t_c;						//save this count to one variable
		end
end		
endmodule		

		
