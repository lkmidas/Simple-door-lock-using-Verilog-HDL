module state_decoder(
    i_state,
    o_7seg
);

    input [2:0] i_state;

    output reg [6:0] o_7seg;

    always @ (i_state) begin
        case (i_state)
            3'b000: o_7seg = 7'b0010010;
            3'b001: o_7seg = 7'b1000001;
            3'b010: o_7seg = 7'b1000001;
            3'b011: o_7seg = 7'b1000001;
            3'b100: o_7seg = 7'b0010010;
            3'b101: o_7seg = 7'b0001110;
            default: o_7seg = 7'b1111111;
        endcase
    end

endmodule