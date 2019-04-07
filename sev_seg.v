`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:36:11 10/15/2018 
// Design Name: 
// Module Name:    sss 
// Project Name: 
// Target Devices: 
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
module sev_seg(clk,dist,en,seg
    );
input [9:0] dist;
input clk;
output reg [7:0] seg;
output reg [2:0] en;
reg nclk;
reg [1:0] segno; 
reg [31:0] count;
reg [3:0] cas;
reg [3:0] a,b,c; 
	initial begin
		seg=8'h80;
		en=0;
		nclk=0;
		count=0;  
	end
	
	always @(posedge clk) begin
		count=count+1;
		if(count==50000) begin
			nclk=~nclk;
			count=0;
		end	
	end
	always begin
		c=dist/100;
		b=(dist%100)/10;
		a=dist%10;
	end
	
	always @(posedge nclk) begin
		case(segno)
			0: begin
				en=3'b110;
				cas=c;
				end
			1: begin
				en=3'b101;
				cas=b;
				end
			2: begin
				en=3'b011;
				cas=a;
				end	
		endcase
			case(cas)
				0: seg=8'hC0;
				1: seg=8'hF9;
				2: seg=8'hA8;
				3: seg=8'hB0;
				4: seg=8'h99;
				5: seg=8'h92;
				6: seg=8'h82;
				7: seg=8'hF8;
				8: seg=8'h80;
				9: seg=8'h90;
			endcase	
		segno=segno+1;	
		if(segno==3)
			segno=0;
	end	
		
endmodule

