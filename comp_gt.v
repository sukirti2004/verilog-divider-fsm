// This is a compartator which compares whether A > B or not
// If A > B then out = 1 else 0;
// this will require two variables gt and eq
// gt will determine whether A[i] > B[i] or not if true then 1 => a[i] $ ~b[i] {Everything is in binary} 
// Also for bits below MSB we also need to & eq[i+1] so that we know that the above bits were equal
// eq will determine whether a[i] and b[i] are equal or not => ~(a[i] ^ b[i])
// we will do this for all bits until we get wq[i] not equal to zero then we will see gt[i] and tell whether A > B is true or not
// After this we will break the loop

module comp_gt(out, inputA, inputB, clock, enable); 
    input [15:0] inputA, inputB;
    input clock, enable;
    output reg out;

    reg [15:0] gt, eq;
    integer i;

    always @(*) begin
        if(enable == 1) begin
            //$display("Comparing A and B");
            for (i=15; i>-1; i=i-1) begin 
                gt[i] = inputA[i] & (~inputB[i]);
                eq[i] = ~(inputA[i] ^ inputB[i]);

                if(eq[i] == 0) begin
                    if(gt[i] == 1)
                        out  = 1;
                    else 
                        out  = 0;
                    i = -1;
                end
            end
            //$display("Compared %d and %d", inputA, inputB);
        end
        
    end


endmodule