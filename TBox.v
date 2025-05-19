
	
module TBox(
    input clk,
    input set,
    input reset,
    input [1:0] row,
    input [1:0] col,
    output [8:0] valid,
    output  [8:0] symbol,
    output  [1:0] game_state
);
wire sike;

wire[8:0]iset;
RowColDecoder gd(row, col, iset);
xnor (sike,valid[0],valid[1],valid[2],valid[3],valid[4],valid[5],valid[6],valid[7],valid[8]);
TCell cell1(clk, set& iset[0],reset, sike, valid[0], symbol[0]);
TCell cell2(clk, set& iset[1],reset, sike, valid[1], symbol[1]);
TCell cell3(clk, set& iset[2],reset, sike, valid[2], symbol[2]);
TCell cell4(clk, set& iset[3],reset, sike, valid[3], symbol[3]);
TCell cell5(clk, set& iset[4],reset, sike, valid[4], symbol[4]);
TCell cell6(clk, set& iset[5],reset, sike, valid[5], symbol[5]);
TCell cell7(clk, set& iset[6],reset, sike, valid[6], symbol[6]);
TCell cell8(clk, set& iset[7],reset, sike, valid[7], symbol[7]);
TCell cell9(clk, set& iset[8],reset, sike, valid[8], symbol[8]);




check_winner bd(valid, symbol,reset, game_state);




   
endmodule
module RowColDecoder (
    input [1:0] row, // 2-bit row input (1 to 3)
    input [1:0] col,
     // 9-bit index
   
    output  reg [8:0] iset); // 2-bit column input (1 to 3)
    // 3-bit index output (0 to 8)
   always@(*)
   begin
    
    if(row==2'b01&&col==2'b01)
    begin
    iset=9'b000000001;
    end
    else if(row==2'b01&&col==2'b10)
    begin
    iset=9'b000000010;
    end
    else if(row==2'b01&&col==2'b11)
    begin
    iset=9'b000000100;
    end
    else if(row==2'b10&&col==2'b01)
    begin
    iset=9'b000001000;
    end
    else if(row==2'b10&&col==2'b10)
    begin
    iset=9'b000010000;
    end
    else if(row==2'b10&&col==2'b11)
    begin
    iset=9'b000100000;
    end
    else if(row==2'b11&&col==2'b01)
    begin
    iset=9'b001000000;
    end
    else if(row==2'b11&&col==2'b10)
    begin
    iset=9'b010000000;
    end
    else if(row==2'b11&&col==2'b11)
    begin
    iset=9'b100000000;
    end

   end
   


   
endmodule
module generat(
    input [8:0] valid,
   
    output  k
);
assign k=~(valid[0]^valid[1]^valid[2]^valid[3]^valid[4]^valid[5]^valid[6]^valid[7]^valid[8]);

endmodule
module check_winner(
    input [8:0] valid,
    input [8:0] symbol,
    input reset,
    output reg [1:0] game_state
);
initial begin
    game_state=2'b00;
end
always@(*)
begin
if(symbol[0]==symbol[1]&&symbol[1]==symbol[2]&&valid[0]&&valid[1]&&valid[2])
begin
    if(symbol[0]==1'b1)
    begin
        game_state=2'b01;
    end
    else
    begin
        game_state=2'b10;
    end

end
else if(symbol[3]==symbol[4]&&symbol[4]==symbol[5]&&valid[3]&&valid[4]&&valid[5])
begin
    if(symbol[3]==1'b1)
    begin
        game_state=2'b01;
    end
    else
    begin
        game_state=2'b10;
    end

end
else if(symbol[6]==symbol[7]&&symbol[7]==symbol[8]&&valid[6]&&valid[7]&&valid[8])
begin
    if(symbol[6]==1'b1)
    begin
        game_state=2'b01;
    end
    else
    begin
        game_state=2'b10;
    end

end
else if(symbol[0]==symbol[3]&&symbol[3]==symbol[6]&&valid[0]&&valid[3]&&valid[6])
begin
    if(symbol[0]==1'b1)
    begin
        game_state=2'b01;
    end
    else
    begin
        game_state=2'b10;
    end

end
else if(symbol[1]==symbol[4]&&symbol[4]==symbol[7]&&valid[1]&&valid[4]&&valid[7])
begin
    if(symbol[1]==1'b1)
    begin
        game_state=2'b01;
    end
    else
    begin
        game_state=2'b10;
    end

end
else if(symbol[2]==symbol[5]&&symbol[5]==symbol[8]&&valid[2]&&valid[5]&&valid[8])
begin
    if(symbol[2]==1'b1)
    begin
        game_state=2'b01;
    end
    else
    begin
        game_state=2'b10;
    end

end
else if(symbol[0]==symbol[4]&&symbol[4]==symbol[8]&&valid[0]&&valid[4]&&valid[8])  
begin
    if(symbol[0]==1'b1)
    begin
        game_state=2'b01;
    end
    else
    begin
        game_state=2'b10;
    end

end
else if(symbol[2]==symbol[4]&&symbol[4]==symbol[6]&&valid[2]&&valid[4]&&valid[6])
begin
    if(symbol[2]==1'b1)
    begin
        game_state=2'b01;
    end
    else
    begin
        game_state=2'b10;
    end

end
else if (valid==9'b111111111)
begin
   
    begin
        game_state=2'b11;
    end
end
else begin if(reset)
    begin
        game_state=2'b00;
    end
end
end


endmodule
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
