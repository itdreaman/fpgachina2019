`timescale 1 ps / 1ps
module dvi_encoder
(
	input           pixelclk,     
	input           pixelclk5x,   
	input           rstin,        
	input[7:0]      blue_din,     
	input[7:0]      green_din,    
	input[7:0]      red_din,      
	input           hsync,        
	input           vsync,        
	input           de,           
	output          tmds_clk_p,
	output          tmds_clk_n,
	output[2:0]     tmds_data_p,  
	output[2:0]     tmds_data_n   
);

wire    [9:0]   red ;
wire    [9:0]   green ;
wire    [9:0]   blue ;

encode encb (
	.clkin      (pixelclk),
	.rstin      (rstin),
	.din        (blue_din),
	.c0         (hsync),
	.c1         (vsync),
	.de         (de),
	.dout       (blue)) ;

encode encr (
	.clkin      (pixelclk),
	.rstin      (rstin),
	.din        (green_din),
	.c0         (1'b0),
	.c1         (1'b0),
	.de         (de),
	.dout       (green)) ;

encode encg (
	.clkin      (pixelclk),
	.rstin      (rstin),
	.din        (red_din),
	.c0         (1'b0),
	.c1         (1'b0),
	.de         (de),
	.dout       (red)) ;
serdes_4b_10to1 serdes_4b_10to1_m0(
	.clk           (pixelclk        ),
	.clkx5         (pixelclk5x      ),
	.datain_0      (blue            ),
	.datain_1      (green           ),
	.datain_2      (red             ),
	.datain_3      (10'b1111100000  ),
	.dataout_0_p   (tmds_data_p[0]  ),
	.dataout_0_n   (tmds_data_n[0]  ),
	.dataout_1_p   (tmds_data_p[1]  ),
	.dataout_1_n   (tmds_data_n[1]  ),
	.dataout_2_p   (tmds_data_p[2]  ),
	.dataout_2_n   (tmds_data_n[2]  ),
	.dataout_3_p   (tmds_clk_p      ),
	.dataout_3_n   (tmds_clk_n      ) 
  ) ; 

endmodule
