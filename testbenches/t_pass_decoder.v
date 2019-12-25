module t_pass_decoder();

    reg en;
    reg [11:0] password;

    wire [6:0] out_7seg_0;
    wire [6:0] out_7seg_1;
    wire [6:0] out_7seg_2;

    pass_decoder UUT(
        .i_en(en),
        .i_password(password),
        .o_7seg_0(out_7seg_0),
        .o_7seg_1(out_7seg_1),
        .o_7seg_2(out_7seg_2)
    );

    initial begin
        $monitor("[%t]\tpassword = %d\ten = %b\tout_7seg_0 = %b\tout_7seg_1 = %b\tout_7seg_2 = %b", $time, password, en, out_7seg_0, out_7seg_1, out_7seg_2);
    end

    integer i;

    initial begin
        password = 12'h666;
        en = 0;
        #1 en = 1;
        for (i = 0; i < 16; i = i + 1) begin
            #1 password = $random;
        end
        #1 $stop;
    end

endmodule