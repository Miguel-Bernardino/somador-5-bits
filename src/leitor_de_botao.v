module leitor_de_botao(
    input btn,  
    input clk,
    output btn_state
);

parameter BTN_TICKS_MAX = 539_999;
reg [19:0] clk_counter = 'b0;

reg btn_lock_read = 1'b0;
reg r_btn_state = 1'b0;

parameter DELAY_INICIAL_TICKS = 5_000_000;
reg [23:0] power_on_counter = 'b0;
reg fpga_ready = 1'b0;

always @(posedge clk) begin
    if (!fpga_ready) begin
        if (power_on_counter < DELAY_INICIAL_TICKS) begin
            power_on_counter <= power_on_counter + 1'b1;
            r_btn_state <= 1'b0; // Mantém o estado do botão "solto" durante o boot
            clk_counter <= 0;
            btn_lock_read <= 1'b0;
        end else begin
            fpga_ready <= 1'b1; // FPGA pronto! Libera a leitura do botão para sempre
        end
    end else begin
        if(!btn) begin
            // Lógica para quando o botão é pressionado
            if (clk_counter < BTN_TICKS_MAX) begin
                clk_counter <= clk_counter + 1'b1;
                r_btn_state <= 1'b0; // Opcional: Mantém o estado do botão como 0 durante a contagem de debounce
            end else begin
                if (btn_lock_read == 1'b0) begin
                    // Debounce concluído: alterna o estado (toggle) e trava leitura até soltar
                    r_btn_state <= 1'b1;
                    btn_lock_read <= 1'b1;
                end

            end
        end else begin
            // Lógica para quando o botão não é pressionado
            btn_lock_read <= 1'b0;
            clk_counter <= 0;
            r_btn_state <= 1'b0; // Opcional: Reseta o estado do botão quando solto
        end
    end
end

assign btn_state = r_btn_state;

endmodule