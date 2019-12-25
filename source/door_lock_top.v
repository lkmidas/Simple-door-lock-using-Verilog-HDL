module door_lock_top(
    i_digit,
    i_confirm_getter,
    i_confirm_FSM,
    i_hard_reset,
    i_switch,
    i_enable_display,
    i_clk,
    o_LED_correct,
    o_LED_incorrect,
    o_trials_7seg,
    o_pass_7seg_0,
    o_pass_7seg_1,
    o_pass_7seg_2,
    o_input_7seg,
    o_state_7seg
);

    input [3:0] i_digit;
    input i_confirm_getter;
    input i_confirm_FSM;
    input i_hard_reset;
    input i_switch;
    input i_enable_display;
    input i_clk;

    output o_LED_correct;
    output o_LED_incorrect;
    output [6:0] o_trials_7seg;
    output [6:0] o_pass_7seg_0;
    output [6:0] o_pass_7seg_1;
    output [6:0] o_pass_7seg_2;
    output [6:0] o_input_7seg;
    output [6:0] o_state_7seg;

    wire [11:0] password;
    wire correct;
    wire incorrect;
    wire [1:0] trials;
    wire i_confirm_getter_pe;
    wire i_confirm_FSM_pe;
    wire i_hard_reset_pe;
    wire i_switch_pe;
    wire [2:0] state;

    parameter CLK_IN = 50_000_000;

    password_getter_sync PG(
        .i_digit(i_digit),
        .i_confirm(i_confirm_getter_pe),
        .i_clk(i_clk),
        .i_reset(i_hard_reset),
        .o_password(password)
    );

    door_lock_FSM FSM(
        .i_password(password),
        .i_confirm(i_confirm_FSM_pe),
        .i_switch(i_switch_pe),
        .i_reset(i_hard_reset_pe),
        .i_clk(i_clk),
        .o_correct(correct),
        .o_incorrect(incorrect),
        .o_trials(trials),
        .o_state(state)
    );

    pass_decoder PD(
        .i_password(password),
        .i_en(i_enable_display),
        .o_7seg_0(o_pass_7seg_0),
        .o_7seg_1(o_pass_7seg_1),
        .o_7seg_2(o_pass_7seg_2)
    );

    led7_decoder LD_inp(
        .i_en(1'b1),
        .i_binary(i_digit),
        .o_7seg(o_input_7seg)
    );

    led7_decoder LD_trials(
        .i_en(1'b1),
        .i_binary(2'b11 - trials),
        .o_7seg(o_trials_7seg)
    );

    state_decoder SD(
        .i_state(state),
        .o_7seg(o_state_7seg)
    );

    LED_blinker #(.CLK_IN(CLK_IN), .FREQ_OUT(1)) LED_R(
        .i_clk(i_clk),
        .i_en(incorrect),
        .i_reset(i_hard_reset),
        .o_blink(o_LED_incorrect)
    );

    LED_blinker #(.CLK_IN(CLK_IN), .FREQ_OUT(5)) LED_G(
        .i_clk(i_clk),
        .i_en(correct),
        .i_reset(i_hard_reset),
        .o_blink(o_LED_correct)
    );

    posedge_detector PD0(
        .i_sig(i_confirm_getter),
        .i_clk(i_clk),
        .o_pe(i_confirm_getter_pe)
    );

    posedge_detector PD1(
        .i_sig(i_confirm_FSM),
        .i_clk(i_clk),
        .o_pe(i_confirm_FSM_pe)
    );

    posedge_detector PD2(
        .i_sig(i_switch),
        .i_clk(i_clk),
        .o_pe(i_switch_pe)
    );

    posedge_detector PD3(
        .i_sig(i_hard_reset),
        .i_clk(i_clk),
        .o_pe(i_hard_reset_pe)
    );

endmodule
