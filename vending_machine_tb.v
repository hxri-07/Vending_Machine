`timescale 1ns/1ps
`include "vending_machine.v"

module vending_machine_tb();
    reg clk;
    reg reset;
    reg rupee_one;
    reg rupee_two;
    wire dispense;
    wire return_one_rupee;
    wire return_two_rupee;
    wire [2:0] state;

    vending_machine uut (
        .clk(clk),
        .reset(reset),
        .rupee_one(rupee_one),
        .rupee_two(rupee_two),
        .dispense(dispense),
        .return_one_rupee(return_one_rupee),
        .return_two_rupee(return_two_rupee),
        .state(state)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task insert_one_rupee;
        begin
            @(negedge clk);
            rupee_one = 1;
            @(negedge clk);
            rupee_one = 0;
            @(negedge clk);
        end
    endtask

    task insert_two_rupee;
        begin
            @(negedge clk);
            rupee_two = 1;
            @(negedge clk);
            rupee_two = 0;
            @(negedge clk);
        end
    endtask

    initial begin
        $dumpfile("vending_machine_tb.vcd");
        $dumpvars(0, vending_machine_tb);

        reset = 0;
        rupee_one = 0;
        rupee_two = 0;

        #20 reset = 1;
        #20 reset = 0;
        
        #20;

        $display("\nTest Case 1: Insert 5 Re_1 coins");
        repeat(5) begin
            insert_one_rupee();
        end
        #20;

        $display("\nTest Case 2: Insert Re_2 + Re_2 + Re_1");
        insert_two_rupee();
        insert_two_rupee();
        insert_one_rupee();
        #20;

        $display("\nTest Case 3: Overpayment with 3 Re_2 coins");
        repeat(3) begin
            insert_two_rupee();
        end
        #20;

        $display("\nTest Case 5: Reset during transaction");
        insert_two_rupee();
        insert_one_rupee();
        #10 reset = 1;
        #20 reset = 0;
        #20;

        #100 $display("\nSimulation completed");
        $finish;
    end

    reg [3:0] total_amount;
    always @(posedge clk) begin
        case(state)
            3'b000: total_amount = 0;
            3'b001: total_amount = 1;
            3'b010: total_amount = 2;
            3'b011: total_amount = 3;
            3'b100: total_amount = 4;
            3'b101: total_amount = 5;
            3'b110: total_amount = 6;
            default: total_amount = 0;
        endcase

        if (reset)
            $display("Time=%0t RESET: State=%b Amount=Re_%0d", $time, state, total_amount);
        else if (rupee_one || rupee_two)
            $display("Time=%0t INPUT: Re_%0d inserted, State=%b Amount=Re_%0d", 
                    $time, rupee_two ? 2 : 1, state, total_amount);
        
        if (dispense)
            $display("Time=%0t OUTPUT: Item dispensed!", $time);
        if (return_one_rupee)
            $display("Time=%0t OUTPUT: Re_1 returned", $time);
        if (return_two_rupee)
            $display("Time=%0t OUTPUT: Re_2 returned", $time);
    end

endmodule
