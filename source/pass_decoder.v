module pass_decoder(
    i_password,
    i_en,
    o_7seg_0,
    o_7seg_1,
    o_7seg_2
);

    input [11:0] i_password;
    input i_en;

    output [6:0] o_7seg_0;
    output [6:0] o_7seg_1;
    output [6:0] o_7seg_2;

    led7_decoder D1(
        .i_en(i_en),
        .i_binary(i_password[3:0]),
        .o_7seg(o_7seg_0)
    );
    led7_decoder D2(
        .i_en(i_en),
        .i_binary(i_password[7:4]),
        .o_7seg(o_7seg_1)
    );
    led7_decoder D3(
        .i_en(i_en),
        .i_binary(i_password[11:8]),
        .o_7seg(o_7seg_2)
    );

endmodule
