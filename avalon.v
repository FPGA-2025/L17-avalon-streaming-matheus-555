module avalon (
    input wire clk,
    input wire resetn,
    output reg valid,
    input wire ready,
    output reg [7:0] data
);

    // insira seu codigo aqui
    localparam RESET             = 3'd0;
    localparam AGUARDA_READY     = 3'd1;
    localparam ESPERA_UM_CICLO   = 3'd2;
    localparam ENVIA_4           = 3'd3;
    localparam ENVIA_5           = 3'd4;
    localparam ENVIA_6           = 3'd5;
    localparam ENCERRA_ENVIO     = 3'd6;

    reg [1:0] estado;
    reg [1:0] proximo_estado;

    always @(posedge clk or negedge resetn) begin
        if(!resetn) begin
            estado = RESET;
            valid  = 0;
            data   = 8'bx;
        end else begin
            estado = proximo_estado;
        end
    end

    always @(estado) begin
        case (estado)
            RESET: begin
                proximo_estado = AGUARDA_READY;
            end

            AGUARDA_READY: begin
                proximo_estado = ready ? ESPERA_UM_CICLO : AGUARDA_READY;
            end

            ESPERA_UM_CICLO: begin
                proximo_estado = ready ? ENVIA_4 : AGUARDA_READY;
            end

            ENVIA_4: begin
                proximo_estado = ready ? ENVIA_5 : AGUARDA_READY;
            end

            ENVIA_5: begin
                proximo_estado = ready ? ENVIA_6 : AGUARDA_READY;
            end

            ENVIA_6: begin
                proximo_estado = ready ? ENCERRA_ENVIO : AGUARDA_READY;
            end 

            ENCERRA_ENVIO: begin
                proximo_estado = AGUARDA_READY;
            end
        endcase
    end

    always @(posedge clk) begin
        valid = 0;
        data  = 8'dx;

        case (estado)
            RESET: begin
            end

            AGUARDA_READY: begin
            end

            ESPERA_UM_CICLO: begin
            end

            ENVIA_4: begin
                data = 8'd4;
            end

            ENVIA_5: begin
                data = 8'd5;
            end

            ENVIA_6: begin
                data = 8'd6;
            end

            ENCERRA_ENVIO: begin
            end
        endcase
    end

endmodule

