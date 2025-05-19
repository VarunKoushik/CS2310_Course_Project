module TCell(input clk, set, reset, set_symbol, output reg valid,symbol);
initial begin
    valid = 1'b0;
end
    always @(posedge clk)
    begin

        if(reset)
        begin
            valid = 0;
            symbol = 0;
        end
        else if(set&~valid)
        begin
            valid = 1;
            symbol = set_symbol;
        end

    end
endmodule