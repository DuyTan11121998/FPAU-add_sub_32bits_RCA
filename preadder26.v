////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// Filename     : preadder26.v                                                //
// Description  : Add 1bit extension and 1 bit sign                           //
//                Get output 26bits for "adder26"                             //   
//                                                                            //
// Author       : tan.nguyen_suunhj98@hcmut.edu.cn                            //
// Created On   : Friday November 22,2019                                     //
//                                                                            //  
////////////////////////////////////////////////////////////////////////////////

module preadder26(
    out1,
    out2,
    sign1,
    sign2,
    frac1,
    frac2
);
    output [25:0]out1,out2;
    input  [23:0]frac1,frac2;
    input  sign1,sign2;

    wire [24:0]temp1,temp2;

    tc25 tc_1(.out(temp1),.in({1'b0,frac1}));
    tc25 tc_2(.out(temp2),.in({1'b0,frac2}));
    // mở rộng dấu để chống tràn//
    assign out1 = sign1?{1'b1,temp1}:{1'b0,frac1};
    assign out2 = sign2?{1'b1,temp2}:{1'b0,frac2};
endmodule