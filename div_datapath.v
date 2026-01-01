// Date : 29-07-2025
// FSM for datapath for division

module div_datapath(LdA, LdB, LdP, enable_comp, select_A, clearP, incP, clock, data_in, ALU_sub, Pout, gt_A_B);

    input LdA, LdB, LdP, clearP, incP, clock, enable_comp, select_A, ALU_sub;
    input [15:0] data_in;
    output [15:0] Pout;
    output gt_A_B;

    wire [15:0] Aout, A2, Bout, Xout, Pout;

    mux mux_A(A2, data_in, Xout, select_A);
    pipo A(Aout, A2, LdA, clock);
    pipo B(Bout, data_in, LdB, clock);
    comp_gt COMP(gt_A_B, Aout, Bout, clock, enable_comp);
    subtractor SUB(Xout, Aout, Bout, ALU_sub);
    countP CNT(Pout, incP, clearP, clock);



endmodule 