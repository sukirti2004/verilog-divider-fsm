module comp_eqz (
    eqz, in
);
    input [15:0] in;
    output eqz;
    
    assign eqz = in? 0 : 1;
endmodule