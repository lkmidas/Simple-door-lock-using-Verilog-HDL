module door_lock_FSM(
    i_password,
    i_confirm,
    i_switch,
    i_reset,
    i_clk,
    o_correct,
    o_incorrect,
    o_trials,
    o_state
);

    input [11:0] i_password;
    input i_confirm;
    input i_switch;
    input i_reset;
    input i_clk;

    output reg o_correct;
    output reg o_incorrect;
    output reg [1:0] o_trials;
    output [2:0] o_state;

    reg [11:0] saved_password;
    reg [2:0] current_state;
    reg [2:0] next_state;
    reg r_correct;
    reg r_incorrect;
    reg [1:0] r_trials;

    localparam [2:0] INITIAL_SET = 3'b000;
    localparam [2:0] VERIFY = 3'b001;
    localparam [2:0] VERIFY_SUCCESS = 3'b010;
    localparam [2:0] VERIFY_FAIL = 3'b011;
    localparam [2:0] SET = 3'b100;
    localparam [2:0] FREEZE = 3'b101;

    always @ (posedge i_clk) begin
        current_state <= next_state;
        o_correct <= r_correct;
        o_incorrect <= r_incorrect;
        o_trials <= r_trials;
    end

    always @ (current_state or i_confirm or i_switch or i_reset) begin
        if (i_reset) begin

            r_correct = 0;
            r_incorrect = 0;
            r_trials = 0;
            saved_password = 0;
            next_state = INITIAL_SET;

        end else begin

            r_correct = 0;
            r_incorrect = 0;
            r_trials = 0;

            case (current_state)
                INITIAL_SET: begin
                    r_correct = 0;
                    r_incorrect = 0;
                    r_trials = 0;
                    if (i_confirm) begin
                        saved_password = i_password;
                        next_state = VERIFY;
                    end else begin
                        next_state = INITIAL_SET;
                    end
                end

                VERIFY: begin
                    r_correct = o_correct;
                    r_incorrect = o_incorrect;
                    if (i_confirm) begin
                        if (saved_password == i_password) begin
                            r_trials = 0;
                            next_state = VERIFY_SUCCESS;
                        end else begin
                            r_trials = o_trials + 1;
                            next_state = VERIFY_FAIL;
                        end
                    end else if (i_switch) begin
                        r_trials = o_trials;
                        next_state = SET;
                    end else begin
                        r_trials = o_trials;
                        next_state = current_state;
                    end
                end

                VERIFY_SUCCESS: begin
                    r_correct = 1;
                    r_incorrect = 0;
                    if (i_confirm) begin
                        if (saved_password == i_password) begin
                            r_trials = 0;
                            next_state = VERIFY_SUCCESS;
                        end else begin
                            r_trials = o_trials + 1;
                            next_state = VERIFY_FAIL;
                        end
                    end else if (i_switch) begin
                        r_trials = o_trials;
                        next_state = SET;
                    end else begin
                        r_trials = o_trials;
                        next_state = current_state;
                    end
                end

                VERIFY_FAIL: begin
                    r_correct = 0;
                    r_incorrect = 1;
                    if (o_trials == 2'd3) begin
                        r_trials = o_trials;
                        next_state = FREEZE;
                    end else if (i_confirm) begin
                        if (saved_password == i_password) begin
                            r_trials = 0;
                            next_state = VERIFY_SUCCESS;
                        end else begin
                            r_trials = o_trials + 1;
                            next_state = VERIFY_FAIL;
                        end
                    end else if (i_switch) begin
                        r_trials = o_trials;
                        next_state = SET;
                    end else begin
                        r_trials = o_trials;
                        next_state = current_state;
                    end
                end

                SET: begin
                    if (i_confirm) begin
                        saved_password = i_password;
                        r_trials = 0;
                        r_correct = 0;
                        r_incorrect = 0;
                        next_state = VERIFY;
                    end else if (i_switch) begin
                        r_trials = o_trials;
                        r_correct = o_correct;
                        r_incorrect = o_incorrect;
                        next_state = VERIFY;
                    end else begin
                        r_trials = o_trials;
                        r_correct = o_correct;
                        r_incorrect = o_incorrect;
                        next_state = current_state;
                    end
                end

                FREEZE: begin
                    r_correct = 0;
                    r_incorrect = 1;
                    r_trials = 3;
                    next_state = current_state;
                end

                default: begin
                    r_correct = 1'bx;
                    r_incorrect = 1'bx;
                    r_trials = 2'bxx;
                    next_state = 3'bxxx;
                end
            endcase
        end
    end

    assign o_state = current_state;

endmodule



    