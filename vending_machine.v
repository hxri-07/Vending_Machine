module vending_machine(
    input wire clk,
    input wire reset,
    input wire rupee_one,
    input wire rupee_two,
    output reg dispense,
    output reg [2:0] state
);

    parameter S0 = 3'b000;  // ₹0
    parameter S1 = 3'b001;  // ₹1
    parameter S2 = 3'b010;  // ₹2
    parameter S3 = 3'b011;  // ₹3
    parameter S4 = 3'b100;  // ₹4
    parameter S5 = 3'b101;  // ₹5 (dispense)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            dispense <= 0;
        end else begin
            case (state)
                S0: begin
                    if (rupee_one) state <= S1;
                    else if (rupee_two) state <= S2;
                end
                S1: begin
                    if (rupee_one) state <= S2;
                    else if (rupee_two) state <= S3;
                end
                S2: begin
                    if (rupee_one) state <= S3;
                    else if (rupee_two) state <= S4;
                end
                S3: begin
                    if (rupee_one) state <= S4;
                    else if (rupee_two) state <= S5;
                end
                S4: begin
                    if (rupee_one) state <= S5;
                    else if (rupee_two) state <= S5;
                end
                S5: begin
                    state <= S0;
                    dispense <= 1;
                end
            endcase
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (state == S5) begin
            dispense <= 1;
        end else begin
            dispense <= 0;
        end
    end

endmodule