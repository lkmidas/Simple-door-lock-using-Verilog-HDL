module t_led7_decoder();

    reg en;
    reg [3:0] binary;

    wire [6:0] out_7seg;

    led7_decoder UUT(
        .i_en(en),
        .i_binary(binary),
        .o_7seg(out_7seg)
    );

    initial begin
        $monitor("[%t]\tbinary = %d\ten = %b\tout_7seg = %b", $time, binary, en, out_7seg);
    end

    integer i;

    initial begin
        binary = 4'h7;
        en = 0;
        #1 en = 1;
        for (i = 0; i < 16; i = i + 1) begin
            #1 binary = i;
        end
        #1 $stop;
    end

endmodule