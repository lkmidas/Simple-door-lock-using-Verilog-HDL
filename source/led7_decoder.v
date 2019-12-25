module led7_decoder(
    i_en,
    i_binary,
    o_7seg
);

    input i_en;
    input [3:0] i_binary;

    output [6:0] o_7seg;

    reg [6:0] value_7seg;

    always @ (i_binary) begin
        case (i_binary)
            4'h0: value_7seg = 7'b1000000;
            4'h1: value_7seg = 7'b1111001;
            4'h2: value_7seg = 7'b0100100;
            4'h3: value_7seg = 7'b0110000;
            4'h4: value_7seg = 7'b0011001;
            4'h5: value_7seg = 7'b0010010;
            4'h6: value_7seg = 7'b0000010;
            4'h7: value_7seg = 7'b1111000;
            4'h8: value_7seg = 7'b0000000;
            4'h9: value_7seg = 7'b0010000;
            4'hA: value_7seg = 7'b0001000;
            4'hB: value_7seg = 7'b0000011;
            4'hC: value_7seg = 7'b1000110;
            4'hD: value_7seg = 7'b0100001;
            4'hE: value_7seg = 7'b0000110;
            4'hF: value_7seg = 7'b0001110;
            default: value_7seg = 7'b1111111;
        endcase
    end

    assign o_7seg = i_en ? value_7seg : 7'b1111111;

endmodule
