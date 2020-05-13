# door_lock
This is the repository for my mini-project in HCMUT's CO2033 - *Logic Design with Verilog*: **Simple 3-digit password door lock using Verilog HDL on DE2I-150 board**. 
## Description
This mini-project is to implement a door lock logic with the following functionalities:
- The password is a 3-digit hexadecimal number whose each digit is in a range from 0 to F.
- The digits are inputted in binary through switches `SW[3:0]`, the confirmation signal for reading in a digit is generated by `KEY[0]`. The current value that the switches represent is shown on `HEX4`.
- The password is passed to the processing state machine when there is a confirmation signal from `KEY[1]`. The value of the inputted password is shown on `HEX2` to `HEX0`, showing password can be enabled/disabled using switch `SW[4]` .
- The design can operate in 3 different modes: SET, VERIFY and FREEZE. The first 2 modes can be interchange using `KEY[2]`. The current operating mode will be shown on `HEX7`.
- In SET mode, user can set a password for the lock. After pressing `KEY[1]` to confirm the password, it will be saved and the mode will change to VERIFY.
- In VERIFY mode, pressing `KEY[1]` will put the current inputted password into a check. If the inputted password is identical to the saved one set earlier, a `LEDG` will blink with 5Hz frequency, otherwise a `LEDR` will blink with 1Hz frequency. The user have 3 trials to check the password, the number of trials will be reset if the password is correct. When it reaches 0, the circuit will enter a FREEZE state. The number of trials will also be shown on `HEX6`.
- In the FREEZE state, only the switches work, all keys mentioned above are disabled. Therefore, the state machine won't work.
- Hard reset signal can be generated by `KEY[3]`. When the circuit is in the FREEZE state, only `KEY[3]` will work and it will reset the whole circuit.
## Implementation
The circuit has 8 modules:
- `posedge_detector()` detects postive edges generated from keys.
- `led7_decoder()` decodes hexadecimal number to 7-segment LED's representation.
- `pass_decoder()` decodes the 3-digit passwords to 7-segment LEDs.
- `LED_blinker()` blinks an LED with a frequency defined by a parameter.
- `state_decoder()` decodes the current state (operating mode) to 7-segment LED.
- `password_getter_sync()` is a synchronous circuit which takes user's input digit by digit from switches and keys.
- `door_lock_FSM()` is a synchronous Mealy finite state machine, this is where all the logic of the design is processed.
- `door_lock_top()` is the top module to connect smaller ones.
### Block diagram of the top modules and I/O of the DE2i-150 board

### State machine flow graph
