module b_door_lock(
    SW,
    KEY,
    CLOCK_50,
    HEX0,
    HEX1,
    HEX2,
    HEX7,
    HEX4,
    HEX6,
    LEDR,
    LEDG
);

    input [17:0] SW;
    input [3:0] KEY;
    input CLOCK_50;

    output [6:0] HEX0;
    output [6:0] HEX1;
    output [6:0] HEX2;
    output [6:0] HEX7;
    output [6:0] HEX4;
    output [6:0] HEX6;
    output [17:0] LEDR;
    output [7:0] LEDG;

    door_lock_top TOP(
        .i_digit(SW[3:0]),
        .i_confirm_getter(~KEY[0]),
        .i_confirm_FSM(~KEY[1]),
        .i_hard_reset(~KEY[3]),
        .i_switch(~KEY[2]),
        .i_enable_display(SW[4]),
        .i_clk(CLOCK_50),
        .o_LED_correct(LEDG[7]),
        .o_LED_incorrect(LEDR[0]),
        .o_trials_7seg(HEX6),
        .o_pass_7seg_0(HEX0),
        .o_pass_7seg_1(HEX1),
        .o_pass_7seg_2(HEX2),
        .o_input_7seg(HEX4),
        .o_state_7seg(HEX7)
    );

endmodule
