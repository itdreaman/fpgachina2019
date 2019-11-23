module filter(
	input                       rst,
	input                       pclk,
	input                       de,
	input[7:0]                  data_in,
	output [7:0]             data_out
);
reg[7:0] p11,p12,p13;
reg[7:0] p21,p22,p23;
reg[7:0] p31,p32,p33;
wire[7:0] p1,p2,p3;
wire [7:0]max1,max2,max3,med1,med2,med3,min1,min2,min3;
wire [7:0]min_of_max,med_of_med,max_of_min;

linebuffer_Wapper#
(
	.no_of_lines(3),
	.samples_per_line(640),
	.data_width(8)
)
 linebuffer_Wapper_m0(
	.ce         (1'b1   ),
	.wr_clk     (pclk   ),
	.wr_en      (de   ),
	.wr_rst     (rst   ),
	.data_in    (data_in),
	.rd_en      (de   ),
	.rd_clk     (pclk   ),
	.rd_rst     (rst   ),
	.data_out   ({p3,p2,p1}  )
   );
always@(posedge pclk)
begin
	p11 <= p1;
	p21 <= p2;
	p31 <= p3;
	
	p12 <= p11;
	p22 <= p21;
	p32 <= p31;
	
	p13 <= p12;
	p23 <= p22;
	p33 <= p32;
end

  compare u11_compare(

             .data_a   (p11) ,  
             .data_b   (p12) ,  
             .data_c   (p13),  
             .data_max  (max1),
             .data_min  (min1),
             .data_med (med1)

             );
 
compare  u12_compare(         
          .data_a  (p21), 
          .data_b  (p22),
          .data_c  (p23),
          .data_max(max2),
          .data_min(min2),
          .data_med(med2));

compare  u13_compare(          
          .data_a  (p31)  ,
          .data_b  (p32)  ,
          .data_c  (p33)  ,
          .data_max(max3) ,
          .data_min(min3) ,
          .data_med(med3)
          );

compare u21_compare(          
          .data_a  (max1)  ,
          .data_b  (max2)  ,
          .data_c  (max3)  ,
          .data_max() ,
          .data_min(min_of_max) ,
          .data_med()
                  
                    );

compare u22_compare(           
          .data_a  (min1)  ,
          .data_b  (min2)  ,
          .data_c  (min3)  ,
          .data_max(max_of_min) ,
          .data_min() ,
          .data_med()
                  
                    );

compare u23_compare(          
          .data_a  (med1)  ,
          .data_b  (med2)  ,
          .data_c  (med3)  ,
          .data_max() ,
          .data_min() ,
          .data_med(med_of_med)
                  
                    );  

compare u3_compare(          
          .data_a  (min_of_max)  ,
          .data_b  (max_of_min)  ,
          .data_c  (med_of_med)  ,
          .data_max() ,
          .data_min() ,
          .data_med(data_out)
                  
                    );                    


endmodule