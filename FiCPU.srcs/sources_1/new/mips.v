`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 01:31:17 PM
// Design Name: 
// Module Name: mips
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


module mips(
    input              clk, reset,
    output   [31:0]    pc,
    input    [31:0]    instr,
    output             memwrite,
    output   [31:0]    aluout, writedata,
    input    [31:0]    readdata
);

wire memtoreg, branch, alusrc, regdst, regwrite, jump;
wire [2:0] alucontrol;

controller c(instr[31:26], instr[5:0], zero, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
datapath dp(clk, reset, memtoreg, pcsrc, alusrc, regdst, regwrite, jump, alucontrol, zero, pc, instr, aluout, writedata, readdata);

always @(*) begin
    $display("/***************************/");
    $display("MIPS: \tPC: %H", pc);
end

endmodule
