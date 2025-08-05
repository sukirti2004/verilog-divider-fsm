module test_div_datapath;

    reg [15:0] data_in;
    reg clock, start;
    wire [15:0] Pout;

    div_datapath DIV(LdA, LdB, LdP, LdXout, enable_comp, sel_mux, clearP, incP, eqz, clock, data_in, ALU_sub, Pout);
    controller CNT(LdA, LdB, LdXout, enable_comp, incP, sel_mux, clearP, eqz, start, done, clock, ALU_sub);

    initial begin
        clock = 1'b0;
        #3 start = 1'b1;
        #500 $finish;
    end

    always #5 clock = ~clock;

    initial begin
        #12 data_in = 28;
        #18 data_in = 4;
    end

    initial begin
        //$monitor($time ," Done = %b", CNT.done);
        $dumpfile("div.vcd");
        $dumpvars(0,test_div_datapath);
    end

    always @(done) begin
        if(done == 1)
            $display("Answer = %d", DIV.Pout);
    end

endmodule