module D_FF_MS (input D, input CLK, input RESET, output Q);
wire t1,t2,t3,t4;

D_a Db(D,CLK,RESET,t2);
D_a Dc(t2,~CLK,RESET,Q);

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