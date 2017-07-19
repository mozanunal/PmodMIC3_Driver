`timescale 1ns / 1ps

//ADCS747x 1-MSPS, 12-Bit, 10-Bit, and 8-Bit A/D Converters

module pmodMic3(
    input clk,
    input miso,
    output sck,
    output reg ss,
    output reg [15:0] out
    );
    
reg [31:0] clkCounter;
reg [15:0] outBuffer;
assign sck = clk;
initial clkCounter = 0;
initial ss = 0;


always @(posedge clk)
   begin
        if (clkCounter < 16)
            begin
                outBuffer[15-clkCounter] <= miso;
                 clkCounter = clkCounter + 32'd1;
            end
        else if (clkCounter == 16)
            begin
                out <= outBuffer;
                clkCounter = clkCounter + 32'd1;
            end
         else if (clkCounter == 17)
            begin
                clkCounter = 32'd0;
            end

    end
        
always @(negedge clk)
    begin
        if (clkCounter == 16)
          begin
            ss <= 1'b1;
          end
        else if (clkCounter == 0)
          begin
            ss <= 1'b0;
          end
    end 
    

 
endmodule
