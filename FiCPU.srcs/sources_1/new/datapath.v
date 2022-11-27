`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 02:04:52 PM
// Design Name: 
// Module Name: datapath
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


module datapath(
    input           clk, reset,
    input           memtoreg, pcsrc,
    input           alusrc, regdst,
    input           regwrite, jump,
    input  [2:0]    alucontrol,
    output          zero,
    output [31:0]   pc,
    input  [31:0]   instr,
    output [31:0]   aluout, writedata,
    input  [31:0]   readdata
);

wire [4:0]  writereg;
wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
wire [31:0] signimm, signimmsh;
wire [31:0] srca, srcb;
wire [31:0] result;

// next PC logic
flopr #(32) pcreg(clk, reset, pcnext, pc);

adder pcadd1 (pc, 32'b100, pcplus4);

sl2 immsh(signimm, signimmsh);

adder pcadd2(pcplus4, signimmsh, pcbranch);

mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);

mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);

// register file logic
regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata);

mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);

mux2 #(32) resmux(aluout, readdata, memtoreg, result);

signext se(instr[15:0], signimm);

// ALU logic
mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);

alu alu(srca, srcb, alucontrol, aluout, zero);

always @(posedge clk) begin
    $display("ALU:\n \tsrca = %d\n \tsrcb = %d\n \talucontrol = %b\n \taluresult = %H\n \tzero = %b", srca, srcb, alucontrol, aluout, zero);
end

endmodule
