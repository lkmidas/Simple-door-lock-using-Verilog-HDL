module posedge_detector(
    i_sig,
    i_clk,
    o_pe
);

    input i_sig;
    input i_clk;

    output o_pe;

    reg sig_delayed;

    always @ (posedge i_clk) begin
        sig_delayed <= i_sig;
    end

    assign o_pe = i_sig & ~sig_delayed; 

endmodule