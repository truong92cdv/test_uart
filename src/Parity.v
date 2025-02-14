module Parity(
    input wire          reset_n,
    input wire [7:0]    data_in,
    input wire [1:0]    parity_type,
    output reg          parity_bit
);

    localparam          ODD = 2'b01,
                        EVEN = 2'b10;
    
    always @(*) begin
        if (!reset_n) parity_bit = 1'b1;
        else begin
            case (parity_type)
                ODD:        parity_bit = ~^data_in;
                EVEN:       parity_bit = ^data_in;
                default:    parity_bit = 1'b1;
            endcase
        end                
    end

endmodule
