module somador5bits(
    input  [5:0] btn,  
    input        rst,
    input        cin,
    input        clk,
    output [5:0] led
);

parameter BTN_TICKS_MAX = 539_999;

wire [5:0] btn_state;

/* Leitura dos botões */

leitor_de_botao leitor_0 (
    .btn(~btn[0]),  
    .clk(clk),
    .btn_state(btn_state[0])
); 

leitor_de_botao leitor_5 (
    .btn(btn[5]),
    .clk(clk),
    .btn_state(btn_state[5])
);

leitor_de_botao leitor_4 (
    .btn(btn[4]),  
    .clk(clk),
    .btn_state(btn_state[4])
);

leitor_de_botao leitor_3 (
    .btn(btn[3]),  
    .clk(clk),
    .btn_state(btn_state[3])
);

leitor_de_botao leitor_2 (
     .btn(btn[2]),  
     .clk(clk),
     .btn_state(btn_state[2])
); 
    
leitor_de_botao leitor_1 (
    .btn(btn[1]),  
    .clk(clk),
    .btn_state(btn_state[1])
);

wire rst_state;

leitor_de_botao leitor_rst (
    .btn(~rst),  
    .clk(clk),
    .btn_state(rst_state)
);

reg [1:0] sel = 2'b00;

// Lógica de leitura dos botões e armazenamento dos valores em a e b
reg [4:0] a = 4'b1;
reg [4:0] b = 4'b1;

reg is_first_pass = 'b1;
reg is_selected = 'b0; 

always @(posedge clk) begin
    if(!is_first_pass) begin
        if(rst_state == 1'b1) begin
            a <= 'b0;
            b <= 'b0;
            sel <= 2'b00;
            is_selected = 1'b0;
        end 
        if(btn_state[0] == 1'b1 && !is_selected) begin
            case (sel) 
                2'b00: begin
                    a <= {btn_state[5], btn_state[4], btn_state[3], btn_state[2], btn_state[1]};
                    sel <= 2'b01;
                    is_selected = 1'b1;
                end
                2'b01: begin
                    b <= {btn_state[5], btn_state[4], btn_state[3], btn_state[2], btn_state[1]};
                    sel <= 2'b10;
                    is_selected = 1'b1;
                end
                
            endcase
        end else if(btn_state[0] == 1'b0 && is_selected) begin
            is_selected <= 1'b0;
        end
    end else begin
        is_first_pass <= 1'b0;
    end
end


wire [4:0] s;
wire cout1, cout2, cout3, cout4, cout5;



// Lógica de soma

somador sum_1 (
    .a(a[0]),
    .b(b[0]),
    .cin('b0),
    .s(s[0]),
    .cout(cout1)
);

somador sum_2 (
    .a(a[1]),
    .b(b[1]),
    .cin(cout1),
    .s(s[1]),
    .cout(cout2)
);

somador sum_3 (
    .a(a[2]),
    .b(b[2]),
    .cin(cout2),
    .s(s[2]),
    .cout(cout3)
);

somador sum_4 (
    .a(a[3]),
    .b(b[3]),
    .cin(cout3),
    .s(s[3]),
    .cout(cout4)
);

somador sum_5 (
    .a(a[4]),
    .b(b[4]),
    .cin(cout4),
    .s(s[4]),
    .cout(cout5)
);



/* checa se o botão de seleção (btn_state[0]) não está pressionado, 
   se não, mostra os estados dos botões, 
   se sim, mostra a soma dos números representados pelos botões 1 a 5 (btn_state[1] a btn_state[5]) e o carry out do último somador (cout5)
*/
assign led = 
     (btn_state[0] != 1'b1) ? ~{ btn_state[1], btn_state[2], btn_state[3], btn_state[4], btn_state[5], btn_state[0] } 
    :(sel == 2'b10)         ? ~{ s[0], s[1], s[2], s[3], s[4], cout5 }
    :{ 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1}; 

endmodule