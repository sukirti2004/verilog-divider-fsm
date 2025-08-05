// Date : 29-07-2025
// FSM for datapath for division

module div_datapath(LdA, LdB, LdP, LdXout, enable_comp, sel_mux_X, clearP, incP, eqz, clock, data_in, ALU_sub, Pout);

    input LdA, LdB, LdP, clearP, incP, clock, enable_comp, LdXout, sel_mux_X, ALU_sub;
    input [15:0] data_in;
    output eqz;
    output [15:0] Pout;

    wire [15:0] Aout, Bout, X, Y, Xout, Pout, mux_X, mux_Y, mux_X2;
    wire gt_A_B, eqz;

    pipo A(Aout, data_in, LdA, clock);
    pipo B(Bout, data_in, LdB, clock);
    pipoX X_out(X, mux_X2, LdXout, clock);
    comp_gt COMP(gt_A_B, Aout, Bout, clock, enable_comp);
    mux X_m(mux_X, Aout, Bout,gt_A_B);
    mux Y_m(mux_Y, Aout, Bout, ~gt_A_B);
    mux X2_m(mux_X2, mux_X, Xout, sel_mux_X);
    subtractor SUB(Xout, X, mux_Y, ALU_sub);
    countP CNT(Pout, incP, clearP, clock);
    comp_eqz EQZ(eqz, X);



endmodule 