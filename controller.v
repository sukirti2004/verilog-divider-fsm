module controller (
    LdA, LdB, enable_comp, select_A, incP, clearP, gt_A_B, start, done, clock, ALU_sub
);
    input clock, gt_A_B, start;
    output reg LdA, LdB, LdP, enable_comp, select_A, incP, clearP, done, ALU_sub;

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;
    
    reg [2:0] state;

    always @(posedge clock) begin
        if (state === 3'bxxx)
          state <= S0;
        case (state)
            S0: if(start == 1) state <= S1;
            S1: state <= S2;
            S2: state <= S3;
            S3: if(gt_A_B == 1) state <= S4;
                else state <= S5;
            S4: state <= S3;
            S5: state <= S5;
            default: state <= S0;
        endcase
    end



    always @(state) begin
        case (state)
            S0: begin
                 LdA = 0; LdB = 0; select_A = 0; enable_comp = 0; clearP = 0; incP = 0; done = 0; ALU_sub = 0;
            end 

            S1: begin  select_A = 1; LdA = 1; end

            S2: begin  select_A = 0; LdA = 0;  #1 LdB = 1; clearP = 1; end

            S3: begin  enable_comp = 1; LdB = 0; clearP = 0; LdA = 0; ALU_sub = 0; incP = 0; end

            S4: begin  enable_comp = 0; ALU_sub = 1; incP = 1; LdA = 1;  end

            S5: begin  done = 1; end
        endcase
    end
endmodule
