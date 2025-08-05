module subtractor(out, inputA, inputB, ALU_sub); 
    input [15:0] inputA, inputB;
    input  clock, ALU_sub;
    output reg [15:0] out;

    always @(ALU_sub) 
        if(ALU_sub == 1) begin out = inputA - inputB; end
    always @(ALU_sub) begin
       // $display(" %d - %d = %d", inputA, inputB, out);
    end
endmodule