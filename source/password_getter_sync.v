module password_getter_sync(
    i_digit,
    i_confirm,
    i_reset,
    i_clk,
    o_password
);

    input [3:0] i_digit;
    input i_confirm;
    input i_reset;
    input i_clk;

    output reg [11:0] o_password;

    always @ (posedge i_clk) begin
        if (i_reset) begin
            o_password <= 12'h000;
        end else begin
            if (i_confirm) begin
                o_password <= (o_password << 4) + i_digit;
            end
        end
    end

endmodule
