///////////////////////////////////////////////////////////////
//                                                           
// Filename     : compare_exp.v                              
// Description  : Compare exponentA and exponentB.
//                Get sign and numbershift.                  
//                                                                              
// Author       : tan.nguyen_suunhj98@hcmut.edu.vn           
// Created Date : Sunday November 10,2019                  
//                                                           
///////////////////////////////////////////////////////////////


module compare_exponent(
    numbershift,  
    sign,
    expA,
    expB 
);
    output [4:0]numbershift;
    output sign;
    input  [7:0]expA,expB;

    wire   [8:0]tempB;
    wire   [8:0]extA,extB;
    wire   [7:0]tc_exp_dif,exp_dif,temp_shift;
    wire	checknumbershift;

    assign  extA={1'b0,expA};
    assign  tempB={1'b0,expB};

    tc9	tc_B(extB,tempB);
    rca9  addA_extB({sign,exp_dif},,extA,extB,1'b0);
    
    //
    tc8    cp2_exp_dif(.out(tc_exp_dif),.in(exp_dif));

    assign temp_shift=sign?tc_exp_dif:exp_dif;   
	//checknumbershift = 1 if temp_shift>=24

    assign checknumbershift=temp_shift[7]|temp_shift[6]|temp_shift[5]|(~temp_shift[7]&~temp_shift[6]&~temp_shift[5]&temp_shift[4]&temp_shift[3]);

    assign numbershift=checknumbershift?5'd0:temp_shift[4:0];
endmodule // compare_exp