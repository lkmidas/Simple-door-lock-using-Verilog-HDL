module LED_blinker(
    i_clk,
    i_en,
    i_reset,
    o_blink
);

    input i_clk;
    input i_en;
    input i_reset;

    output o_blink;

    reg [31:0] cnt;
    reg hz_out;

    parameter CLK_IN = 500;
    parameter FREQ_OUT = 5;
    localparam THRESHOLD = CLK_IN / (2*FREQ_OUT);

    always @ (posedge i_clk) begin
        if (i_reset) begin
            cnt <= 0;
            hz_out <= 0;
        end else begin
            if (cnt < THRESHOLD - 1) begin
                cnt <= cnt + 1;
            end else begin
                cnt <= 0;
                hz_out <= ~hz_out;
            end
        end
    end

    assign o_blink = hz_out & i_en;

endmodule

