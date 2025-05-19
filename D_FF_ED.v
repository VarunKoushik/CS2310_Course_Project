module D_FF_ED (input D, input CLK, input RESET, output Q);
wire t1,t2,t3,t4;
not(t1,CLK);
and(t2,CLK,t1);

D_a Db(D,t2,RESET,Q);


endmodule
module D_a(input  d, input en,input rstn, output reg  Q);
    
    always @(en,d,rstn)
    begin
        if(rstn)
            Q <= 1'b0;
        else if(en)
            Q <= d;
    end
endmodule