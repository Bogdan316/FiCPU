`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 02:35:58 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
    input      [31:0] srca, srcb,
    input      [2:0]  alucontrol,
    output reg [31:0] aluresult,
    output            zero
);

reg [31:0] aux;

always @(*) begin
    case(alucontrol)
        3'b000:     aluresult = srca & srcb;          // and
        3'b001:     aluresult = srca | srcb;          // or
        3'b010:     aluresult = srca + srcb;          // add
        3'b110:     aluresult = srca + ~srcb + 32'b1; // subtract
        3'b111:                                       // set less than
            begin
                aux = srca + ~srcb + 32'b1;
                aluresult = {31'b0, aux[31]};         // zero extend
            end     
        default:    aluresult = 32'bx;
    endcase
end

assign zero = (aluresult == 0);

//always @(*) begin
//    $display("ALU:\n \tsrca = %d\n \tsrcb = %d\n \talucontrol = %b\n \taluresult = %H\n \tzero = %b", srca, srcb, alucontrol, aluresult, zero);
//end

endmodule
