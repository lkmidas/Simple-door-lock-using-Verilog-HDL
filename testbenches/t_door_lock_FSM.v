module t_door_lock_FSM();

    reg [11:0] password;
    reg confirm;
    reg switch;
    reg reset;
    reg clk;

    wire correct;
    wire incorrect;
    wire [1:0] trials;
    wire [2:0] state;

    door_lock_FSM UUT(
        .i_password(password),
        .i_confirm(confirm),
        .i_switch(switch),
        .i_reset(reset),
        .i_clk(clk),
        .o_correct(correct),
        .o_incorrect(incorrect),
        .o_trials(trials),
        .o_state(state)
    );

    initial clk = 0;
    always #1 clk = ~clk;

    integer i;

    initial begin
        confirm = 0;
        reset = 0;
        switch = 0;
        password = 12'h000;
        // RESET
        #2 reset = 1;
        #2 reset = 0;
        // Testing INITIAL SET state
        #2 password = 12'hBAD;
        confirm = 1;
        #2 confirm = 0;
        // Testing VERIFY state correct password
        #2 password = 12'hBAD;
        confirm = 1;
        #2 confirm = 0;
        // Testing VERIFY state wrong password
        for (i = 0; i < 3; i = i + 1) begin
            #2 password = 12'h666;
            confirm = 1;
            #2 confirm = 0;
        end
        // Testing FREEZE state
        #2 password = 12'hBAD;
        confirm = 1;
        #2 confirm = 0;
        #2 switch = 1;
        #2 switch = 0;
        // RESET
        #2 reset = 1;
        #2 reset = 0;
        #2 password = 12'hBAD;
        confirm = 1;
        #2 confirm = 0;
        // Testing SET state
        #2 switch = 1;
        #2 switch = 0;
        #2 password = 12'hCEB;
        confirm = 1;
        #2 confirm = 0;
        #2 password = 12'hCEB;
        confirm = 1;
        #2 confirm = 0;
        #4 $stop;
    end

endmodule
