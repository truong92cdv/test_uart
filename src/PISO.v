module PISO(
    input wire          reset_n,
    input wire          send,
    input wire          baud_clk,
    input wire          parity_bit,
    input wire [7:0]    data_in,
    output reg          data_tx,
    output reg          active_flag,
    output reg          done_flag
);

    localparam          IDLE    = 1'b0, 
                        ACTIVE  = 1'b1;

    reg                 STATE = IDLE;
    reg [3:0]           count = 0;
    wire [10:0]         data_out;
    
    assign data_out = {1'b1, parity_bit, data_in, 1'b0};

    always @(posedge baud_clk or negedge reset_n) begin
        if (!reset_n) begin
            STATE <= IDLE;
            data_tx <= 1'b1;
            active_flag <= 1'b0;
            done_flag <= 1'b0;
        end else begin
            case (STATE)
                IDLE: begin
                    if (send) STATE <= ACTIVE;
                        else STATE <= IDLE;
                    data_tx <= 1'b1;
                    active_flag <= 1'b0;
                    count <= 4'd0;
                end
                ACTIVE: begin
                    if (count == 11) begin
                        STATE <= IDLE;
                        data_tx <= 1'b1;
                        active_flag <= 1'b0;
                        done_flag <= 1'b1;  
                        count <= 0;
                    end else begin
                        STATE <= ACTIVE;
                        data_tx <= data_out[count];
                        active_flag <= 1'b1;
                        done_flag <= 1'b0;
                        count <= count + 1'b1;
                    end
                end
            endcase
        end
    end

endmodule