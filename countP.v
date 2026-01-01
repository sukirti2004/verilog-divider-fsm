module countP(Pout, incP, clearP, clock);
    input  clock, clearP, incP;
    output reg [15:0] Pout;

    always @(posedge clock) begin
        if(clearP == 1) Pout <= 0;
        else if(incP == 1) Pout <= Pout + 1; 
    end

endmodule