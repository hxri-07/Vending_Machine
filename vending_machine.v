module vending_machine(
    input wire clk,
    input wire reset,
    input wire rupee_one,
    input wire rupee_two,
    output reg dispense,
    output reg return_one_rupee,
    output reg return_two_rupee,
    output reg [2:0] state
);

    localparam S0 = 3'b000;  
    localparam S1 = 3'b001;  
    localparam S2 = 3'b010;  
    localparam S3 = 3'b011;  
    localparam S4 = 3'b100;  
    localparam S5 = 3'b101;  
    localparam S6 = 3'b110;  

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            dispense <= 0;
            return_one_rupee <= 0;
            return_two_rupee <= 0;
        end else begin
            dispense <= 0;
            return_one_rupee <= 0;
            return_two_rupee <= 0;
            
            case (state)
                S0: begin
                    if (rupee_one) state <= S1;
                    else if (rupee_two) state <= S2;
                    else state <= S0;
                end
                S1: begin
                    if (rupee_one) state <= S2;
                    else if (rupee_two) state <= S3;
                    else state <= S1;
                end
                S2: begin
                    if (rupee_one) state <= S3;
                    else if (rupee_two) state <= S4;
                    else state <= S2;
                end
                S3: begin
                    if (rupee_one) state <= S4;
                    else if (rupee_two) state <= S5;
                    else state <= S3;
                end
                S4: begin
                    if (rupee_one) state <= S5;
                    else if (rupee_two) state <= S6;
                    else state <= S4;
                end
                S5: begin
                    if (rupee_one) begin
                        return_one_rupee <= 1; 
                        dispense <= 1;
                        state <= S0;
                    end
                    else if (rupee_two) begin
                        return_two_rupee <= 1;  
                        dispense <= 1;
                        state <= S0;
                    end
                    else begin
                        dispense <= 1;
                        state <= S0;
                    end
                end
                S6: begin
                    if (rupee_one) begin
                        return_two_rupee <= 1;  // Return ₹2 (1 change + 1 inserted)
                        dispense <= 1;
                        state <= S0;
                    end
                    else if (rupee_two) begin
                        return_one_rupee <= 1;  
                        return_two_rupee <= 1; 
                        dispense <= 1;
                        state <= S0;
                    end
                    else begin
                        dispense <= 1;
                        return_one_rupee <= 1; 
                        state <= S0;
                    end
                end
                default: begin
                    state <= S0;
                    dispense <= 0;
                    return_one_rupee <= 0;
                    return_two_rupee <= 0;
                end
            endcase
        end
    end
endmodule
