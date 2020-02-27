////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// Filename     : add_sub.v                                                   //
// Description  : subtraction and addition floating 32 bits                   //
//                                                                            //
// Author       : tan.nguyen_suunhj98@hcmut.edu.cn                            //
// Created On   : Friday November 22,2019                                     //
//                                                                            //  
////////////////////////////////////////////////////////////////////////////////


module add_sub(
    S,
    A,
    B,
    sub_or_add
);
    output [31:0]S; // Result
    input [31:0]A,B;//floating 32bits
    input  sub_or_add;
//-----------------------------Extract floating-point A and B -----------------------------//
    wire signA,signB,signS;
    wire [7:0]expA,expB,expS;
    wire [23:0]fracA,fracB,fracS;
    
    assign signA = A[31];
    assign signB = B[31]^sub_or_add;
    assign expA = A[30:23];
    assign expB = B[30:23];
    assign fracA = {1'b1,A[22:0]};
    assign fracB = {1'b1,B[22:0]};

//-----------------------------------------Signals-----------------------------------------//
    wire expA_sign_expB;
    wire [7:0]exp_before_normal;
    wire [23:0]frac_before_shift,frac_after_shift,frac_not_shift;
    wire [4:0]shift_right_by_n;//so lan shift (toi da 23 lan shift)
    wire sign_shift,sign_not_shift;
    wire [25:0]before_add_1,before_add_2,after_add;
    wire [24:0]frac_before_normal;

        ////////////////////////////////////////////////////////////
        //          Compare and choose exponent A and B           // 
        //          expA_sign_expB=1 => expA <  expB              //
        //          expA_sign_expB=0 => expA >= expB              //
        //          exp_before_normal = exp_big                   //
        ////////////////////////////////////////////////////////////

    compare_exponent     compare_exponent(
        .numbershift(shift_right_by_n),
        .sign(expA_sign_expB),
        .expA(expA),
        .expB(expB)
    );
    mux8		mux_choose_exp(
        .out(exp_before_normal),
        .A(expA),.B(expB),
        .sel(expA_sign_expB)
    );

        //////////////////////////////////////////////////////////////
        //         Shift and add frac A to B                        // 
        //         Choose and shift frac                            //
        //         expA_sign_expB=1 => expA <  expB => shift frac A //
        //         expA_sign_expB=0 => expA >= expB => shift frac B //
        //////////////////////////////////////////////////////////////

    mux24		mux_not_shift(
        .out(frac_not_shift),
        .A(fracA),.B(fracB),
        .sel(expA_sign_expB)
        );	
    mux24		mux_shift_right(
        .out(frac_before_shift),
        .A(fracB),
        .B(fracA),
        .sel(expA_sign_expB)
        );
    shiftright24	shift_right24bit(
        .out(frac_after_shift),
        .in(frac_before_shift),
        .sel(shift_right_by_n)
        );
//-------------------------Choose sign for 2 fraction---------------------//
    mux1		mux_choose_sign_not_shift(
        .out(sign_not_shift),
        .A(signA),
        .B(signB),
        .sel(expA_sign_expB)
        );
    mux1		mux_choose_sign_shift(
        .out(sign_shift),
        .A(signB),
        .B(signA),
        .sel(expA_sign_expB)
        );
    
//-------------------------Add 2 fraction---------------------//
    preadder26      preproccess(
        .out1(before_add_1),
        .out2(before_add_2),
        .sign1(sign_shift),
        .sign2(sign_not_shift),
        .frac1(frac_after_shift),
        .frac2(frac_not_shift)
    );
    rca26		    process_add(
        after_add,
        ,
        before_add_1,
        before_add_2,
        1'b0
    );
    postadder26	    postprocess(
        .sign(signS),
        .frac(frac_before_normal),
        .in(after_add)
    );

//-------------------------Normalize the fraction answer---------------------//
    normalize	normalize_ans(
        .exp_out(expS),
        .frac_out(fracS),
        .exp_in(exp_before_normal),
        .frac_in(frac_before_normal)
    );


//-------------------------Export S---------------------//
    resultS_addsub	result_S_value(
        .S(S),
        .A({signA,expA,fracA[22:0]}),
        .B({signB,expB,fracB[22:0]}),
        .ansS({signS,expS,fracS[22:0]})
        );
endmodule