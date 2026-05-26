# Somador 5 bits

Resumo

Projeto Verilog de um somador (implementações em `src/`) desenvolvido para fins educacionais e de síntese em FPGA. Inclui módulos de adição e leitura de botões, junto com arquivos de restrições e relatórios de síntese/implementação.

Plataforma alvo

- FPGA: Tang Nano 20k

Estrutura do repositório

- `src/` — código-fonte RTL (Verilog):
  - `somador.v` — módulo principal do somador
  - `somador5bits.v` — versão/esqueleto do somador de 5 bits
  - `leitor_de_botao.v` — tratamento/condicionamento de entradas por botão
  - `somador.cst` — arquivo de restrições (pinos/clock)
- `impl/` — resultados de síntese e implementação (relatórios, mapas de recursos, binários)

Como usar

- Para simular: use sua ferramenta Verilog preferida (por exemplo, Icarus Verilog + GTKWave) apontando para os arquivos em `src/`.
- Para sintetizar/implementar: importe o projeto na sua ferramenta de síntese compatível com a placa Tang Nano 20k, carregue o arquivo de restrições e gere o bitstream/binário.

Notas

- O projeto foi desenvolvido e testado visando a placa Tang Nano 20k; ajustes em restrições de pinos podem ser necessários conforme a revisão da placa ou do footprint do conector.

Autor

- Desenvolvido por: Miguel Bernardino Sousa Borges da Silva
