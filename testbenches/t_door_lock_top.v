`timescale 1ps/1ps
module t_door_lock_top();

    reg [3:0] digit;
    reg confirm_getter;
    reg confirm_FSM;
    reg hard_reset;
    reg switch;
    reg enable_display;
    reg clk;

    wire LED_correct;
    wire LED_incorrect;
    wire [6:0] trials_7seg;
    wire [6:0] pass_7seg_0;
    wire [6:0] pass_7seg_1;
    wire [6:0] pass_7seg_2;
    wire [6:0] input_7seg;
    wire [6:0] state_7seg;

    integer i;

    door_lock_top #(500) UUT(
        .i_digit(digit),
        .i_confirm_getter(confirm_getter),
        .i_confirm_FSM(confirm_FSM),
        .i_hard_reset(hard_reset),
        .i_switch(switch),
        .i_enable_display(enable_display),
        .i_clk(clk),
        .o_LED_correct(LED_correct),
        .o_LED_incorrect(LED_incorrect),
        .o_trials_7seg(trials_7seg),
        .o_pass_7seg_0(pass_7seg_0),
        .o_pass_7seg_1(pass_7seg_1),
        .o_pass_7seg_2(pass_7seg_2),
        .o_input_7seg(input_7seg),
        .o_state_7seg(state_7seg)
    );

    initial clk = 0;
    always #1 clk = ~clk;

    initial begin
        confirm_getter = 0;
        confirm_FSM = 0;
        switch = 0;
        digit = 4'h0;
        hard_reset = 0;
        enable_display = 1;
        // RESET
        #50 hard_reset = 1;
        #50 hard_reset = 0;
        // Testing INITIAL state
        #50 digit = 4'hB;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hA;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hD;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 confirm_FSM = 1;
        #50 confirm_FSM = 0;
        #50 enable_display = 0;
        // Testing VERIFY state correct password
        #50 digit = 4'hB;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hA;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hD;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 confirm_FSM = 1;
        #50 confirm_FSM = 0;
        // Testing VERIFY state wrong password
        for (i = 0; i < 3; i = i + 1) begin
            #50 digit = 4'h6;
            #50 confirm_getter = 1;
            #50 confirm_getter = 0;
            #50 digit = 4'h6;
            #50 confirm_getter = 1;
            #50 confirm_getter = 0;
            #50 digit = 4'h6;
            #50 confirm_getter = 1;
            #50 confirm_getter = 0;
            #50 confirm_FSM = 1;
            #50 confirm_FSM = 0;
        end
        // Testing FREEZE state
        #50 digit = 4'hB;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hA;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hD;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 confirm_FSM = 1;
        #50 confirm_FSM = 0;
        #50 switch = 1;
        #50 switch = 0;
        // RESET
        #50 hard_reset = 1;
        #50 hard_reset = 0;
        #50 digit = 4'hB;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hA;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hD;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 confirm_FSM = 1;
        #50 confirm_FSM = 0;
        // Testing SET state
        #50 switch = 1;
        #50 switch = 0;
        #50 digit = 4'hC;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hE;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hB;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 confirm_FSM = 1;
        #50 confirm_FSM = 0;
        #50 digit = 4'hC;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hE;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 digit = 4'hB;
        #50 confirm_getter = 1;
        #50 confirm_getter = 0;
        #50 confirm_FSM = 1;
        #50 confirm_FSM = 0;
        #50 $stop;
    end

endmodule
