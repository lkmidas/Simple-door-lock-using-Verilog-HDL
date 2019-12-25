module t_state_decoder();

    reg [2:0] state;

    wire [6:0] out_7seg;

    state_decoder UUT(
        .i_state(state),
        .o_7seg(out_7seg)
    );

    integer i;

    initial begin
        for (i = 0; i < 6; i = i + 1) begin
            #1 state = i;
        end    
        #1 $stop;
    end
    

endmodule
