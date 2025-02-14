module top(
    input       CLK,
    input       BTN,
    output      TX
);

    reg       reset_n       = 1;            // active state
    reg       send          = 1;
    reg [1:0] parity_type   = 2'b01;        // ODD parity
    reg [1:0] baud_rate     = 2'b10;        // 9600 baud rate
    reg [7:0] data_in; 

    //  wires to show the output
    wire      data_tx;
    //wire      active_flag;
    //wire      done_flag; 

    //  Instance for the design module
    TxUnit ForTest(
        //  Inputs
        .reset_n(reset_n),
        .send(send), 
        .clock(CLK),
        .parity_type(parity_type),
        .baud_rate(baud_rate),
        .data_in(data_in),

        //  Outputs
        .data_tx(data_tx),
        .active_flag(active_flag),
        .done_flag(done_flag)
    );

    assign TX = data_tx;

    always @(posedge BTN) begin
        data_in <= 8'd84;           // ASCII of 'T'
    end

endmodule
