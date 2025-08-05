module controller (
    LdA, LdB, LdXout, enable_comp, incP, sel_mux_X, clearP, eqz, start, done, clock, ALU_sub
);
    input clock, eqz, start;
    output reg LdA, LdB, LdP, LdXout, enable_comp, sel_mux_X, incP, clearP, done, ALU_sub;

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;
    
    reg [2:0] state;

    always @(posedge clock) begin
        if (state === 3'bxxx)
          state <= S0;
        case (state)
            S0: if(start == 1) state <= S1;
            S1: state <= S2;
            S2: state <= S3;
            S3: state <= S4;
            S4: state <= S5;
            S5: state <= S6;
            S6:begin
                if(eqz == 1) state<= S7;
                else state<= S4;
            end
            S7: state <= S7;
            default: state <= S0;
        endcase
    end



    always @(state) begin
        case (state)
            S0: begin
                 LdA = 0; LdB = 0; LdXout = 0; enable_comp = 0; clearP = 0; incP = 0; done = 0; sel_mux_X = 0; ALU_sub = 0;
            end 

            S1:  LdA = 1; 

            S2: begin  LdA = 0;  #1 LdB = 1; clearP = 1; end

            S3: begin  enable_comp = 1; LdB = 0; sel_mux_X = 1; LdXout = 1; clearP = 0;end

            S4: begin  enable_comp = 0; ALU_sub = 0; sel_mux_X = 0; LdXout = 0; end

            S5: begin  incP = 1; ALU_sub = 1; LdXout = 1; end

            S6: begin  incP = 0; LdXout = 0; end

            S7: done = 1; 
        endcase
    end
endmodule
