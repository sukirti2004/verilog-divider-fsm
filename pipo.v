// This is a parallel in parallel out module 

module pipo(out, in, load, clock);
    input [15:0] in;
    input load, clock;
    output reg [15:0] out;

    always @(posedge clock) begin 
        if(load == 1) begin
            out <= in;
            //$display("Currently at PIPO %d and output %d", in, out); 
            end
    end
 
endmodule