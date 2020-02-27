
////////////////////////////////////////////////////////
//                                                    //
// Filename     : rca.v                               //
// Description  : adder with rca                      //
//                                                    //                  
// Author       : hang.nguyen4264@hcmut.edu.vn        //
// Created On   : Friday December 13,2019             //
//                                                    //
////////////////////////////////////////////////////////

module fa(output s,output cout, input a,input b,input cin);
wire g,p,gout,pout,c0;
assign g= a&b;
assign p= a^b;

assign c0=cin;
assign pout=p;
assign gout=g;
    
assign s=p^c0;
assign cout=g|(cin&p);

endmodule
///////////////////////////////////////////////////////////////////////////

module rca8(s,cout,a,b,cin);

output [7:0]s;
output cout;
input cin;
input [7:0]a,b;
wire [8:0]c;
fa  add0(s[0],c[1],a[0],b[0],cin);
fa  add1(s[1],c[2],a[1],b[1],c[1]);
fa  add2(s[2],c[3],a[2],b[2],c[2]);
fa  add3(s[3],c[4],a[3],b[3],c[3]);
fa  add4(s[4],c[5],a[4],b[4],c[4]);
fa  add5(s[5],c[6],a[5],b[5],c[5]);
fa  add6(s[6],c[7],a[6],b[6],c[6]);
fa  add7(s[7],cout,a[7],b[7],c[7]);

endmodule

///////////////////////////////////////////////////////////////////////

module rca16(s,cout,a,b,cin);
output [15:0]s;
output cout;
input  [15:0]a,b;
input  cin;

wire    c1;

rca8    add1(s[7:0],c1,a[7:0],b[7:0],cin);
rca8    add2(s[15:8],cout,a[15:8],b[15:8],c1);

endmodule
////////////////////////////////////////////////////////////////////////

module rca9(s,cout,a,b,cin);
output  [8:0]s;
output  cout;
input   [8:0]a,b;
input   cin;

wire   m1;

rca8   add1(s[7:0],m1,a[7:0],b[7:0],cin);
fa     add2(s[8],cout,a[8],b[8],m1);

endmodule

//////////////////////////////////////////////////////////////////////

module rca10(s,cout,a,b,cin);
output  [9:0]s;
output  cout;
input   [9:0]a,b;
input   cin;

wire   m1;

rca9   add1(s[8:0],m1,a[8:0],b[8:0],cin);
fa     add2(s[9],cout,a[9],b[9],m1);

endmodule

//////////////////////////////////////////////////////////////////

module rca25(s,cout,a,b,cin);
output [24:0]s;
output cout;
input  [24:0]a,b;
input  cin;

wire    c1;
rca16   add1(s[15:0],c1,a[15:0],b[15:0],cin);
rca9    add3(s[24:16],cout,a[24:16],b[24:16],c1);
endmodule

module rca26(s,cout,a,b,cin);
output [25:0]s;
output cout;
input  [25:0]a,b;
input  cin;

wire    m1,m2,m3;

rca25    add1(s[24:0],m1,a[24:0],b[24:0],cin);
fa       add2(s[25],cout,a[25],b[25],m1);

endmodule

////////////////////////////////////////////////////////////////
