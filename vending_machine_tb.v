`include "vending_machine.v"

module vending_machine_tb;

    reg clk;
    reg reset;
    reg rupee_one;
    reg rupee_two;
    wire dispense;
    wire [2:0] state;

    vending_machine uut (
        .clk(clk),
        .reset(reset),
        .rupee_one(rupee_one),
        .rupee_two(rupee_two),
        .dispense(dispense),
        .state(state)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        
        $dumpfile("vending_machine_tb.vcd");
        $dumpvars(0, vending_machine_tb);

        reset = 1;
        rupee_one = 0;
        rupee_two = 0;
        
        #10 reset = 0;
        
        #10 rupee_one = 1;
        #10 rupee_one = 0;
        #10 rupee_one = 1;
        #10 rupee_one = 0;
        #10 rupee_one = 1;
        #10 rupee_one = 0;
        #10 rupee_one = 1;
        #10 rupee_one = 0;
        #10 rupee_one = 1;
        #10 rupee_one = 0;
        
        #20 rupee_two = 1;
        #10 rupee_two = 0;
        #10 rupee_two = 1;
        #10 rupee_two = 0;
        #10 rupee_one = 1;
        #10 rupee_one = 0;
        
        #20 rupee_two = 1;
        #10 rupee_two = 0;
        #10 rupee_two = 1;
        #10 rupee_two = 0;
        #10 rupee_two = 1;
        #10 rupee_two = 0;
        
        #20 $finish;
    end

    initial begin
        $monitor("Time=%0t, Reset=%b, ₹1=%b, ₹2=%b, State=%b, Dispense=%b",
                 $time, reset, rupee_one, rupee_two, state, dispense);
    end

endmodule