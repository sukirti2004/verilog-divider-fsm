module mux(out, in1, in0, select); 
    input [15:0] in1, in0;
    input select;
    output  [15:0] out;


    assign out = select? in1 : in0;
    always @(in0 or in1 or select) begin
    #0;  // zero‐delay lets the assign settle
        //$display("Currently selecting between %0d and %0d with select %b and selected %0d",in0, in1, select, out);
    end

endmodule