module somador(
    input a,
    input b,
    input cin,
    output s,
    output cout
    
); 


wire w1;

assign s = a ^ b ^ cin; // XOR para o bit de soma final
assign cout = a&b | a&cin | b&cin; // AND-OR para o bit de carry out

endmodule