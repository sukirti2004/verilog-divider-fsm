module test_div_datapath;

    reg [15:0] data_in;
    reg clock, start;
    wire [15:0] Pout;

    div_datapath DIV(LdA, LdB, LdP, enable_comp, select_A, clearP, incP, clock, data_in, ALU_sub, Pout, gt_A_B);
    controller CNT(LdA, LdB, enable_comp, select_A, incP, clearP, gt_A_B, start, done, clock, ALU_sub);

    initial begin
        clock = 1'b0;
        #3 start = 1'b1;
        #500 $finish;
    end

    always #5 clock = ~clock;

    initial begin
        #12 data_in = 12;
        #18 data_in = 5;
    end

    initial begin
        //$monitor($time ," Done = %b", CNT.done);
        $dumpfile("div.vcd");
        $dumpvars(0,test_div_datapath);
    end

    always @(done) begin
        if(done == 1)
            $display("Quotient = %d and Remainder = %d",DIV.Pout, DIV.Aout);
    end

endmodule