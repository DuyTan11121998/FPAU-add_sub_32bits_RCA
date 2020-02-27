////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// Filename     : postadder26.v                                               //
// Description  : separate sign  and values(>0)                  `            //
//                                                                            //
// Author       : tan.nguyen_suunhj98@hcmut.edu.cn                            //
// Created On   : Túeday November 12,2019                                     //
//                                                                            //  
////////////////////////////////////////////////////////////////////////////////

module postadder26(sign,frac,in);
output	sign;
output	[24:0]frac;
input	[25:0]in;

wire	[24:0]temp,tctemp;

assign	sign=in[25];
	
assign 	temp=in[24:0];
tc25	tcfrac25(.out(tctemp),.in(temp));
assign	frac=sign?tctemp:temp;

endmodule
