////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// Filename     : add_sub_tb.v                                                //
// Description  : Test subtraction and addition floating 32 bits              //
//                                                                            //
// Author       : tan.nguyen_suunhj98@hcmut.edu.cn                            //
// Created On   : Friday November 22,2019                                     //
//                                                                            //  
////////////////////////////////////////////////////////////////////////////////

module add_sub_tb;
reg [31:0] A,B;
reg add_or_sub;

wire [31:0]S;

add_sub tb(S,A,B,add_or_sub);

initial begin
	A=32'h41CB1893;
	B=32'h419F8000;
	add_or_sub=0;
#100
	A=32'hC1F0E148;
	B=32'h4278D2F2;
	add_or_sub=0;
#100 
	A=32'hC1740000;
	B=32'h40166666;
	add_or_sub=1;
#100
	A=32'h465ac000;
	B=32'h46dac000;
	add_or_sub=0;
#100
	A=32'h7f800000;
	B=32'h00000000;
	add_or_sub=0;
#100
	A=32'h7f800000;
	B=32'h7f800000;
	add_or_sub=0;	
#100
	A=32'hff800000;
	B=32'h40166666;
	add_or_sub=0;
#100
	A=32'h00000000;
	B=32'h00000000;
	add_or_sub=1;
#100
	A=32'h7f800000;
	B=32'h7f800000;
	add_or_sub=1;
#100
	A=32'h7fffffff;
	B=32'h40166666;
	add_or_sub=1;
#100
	A=32'hff800000;
	B=32'hff800000;
	add_or_sub=1;
#100
	A=32'h41E40000;
	B=32'h40F40000;
	add_or_sub=0;
#100
	A=32'h41100000;
	B=32'h41600000;
	add_or_sub=0;
#100
	A=32'h41100000;
	B=32'h41600000;
	add_or_sub=0;
end

endmodule
