`include"D_FF_ED.v"

module RIPPLE_COUNTER (input CLK, input RESET, output [3:0] COUNT);
wire t1,t2,t3,t4;
not(t1,COUNT[0]);
not(t2,COUNT[1]);
not(t3,COUNT[2]);
not(t4,COUNT[3]);




D_FF_ED db(t1,CLK,RESET,COUNT[0]);
D_FF_ED dc(t2,t1,RESET,COUNT[1]);
D_FF_ED dd(t3,t2,RESET,COUNT[2]);
D_FF_ED de(t4,t3,RESET,COUNT[3]);


endmodule

