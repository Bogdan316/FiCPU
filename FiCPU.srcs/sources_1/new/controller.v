`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 01:47:25 PM
// Design Name: 
// Module Name: controller
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


module controller(
    input  [5:0] op,
    input  [5:0] funct,
    input        zero,
    output       memtoreg,
    output       memwrite,
    output       pcsrc, 
    output       alusrc,
    output       regdst,
    output       regwrite,
    output       jump,
    output [2:0] alucontrol
);

wire [1:0] aluop;
wire branch;

maindec md(
    op,
    memtoreg,
    memwrite,
    branch,
    alusrc,
    regdst,
    regwrite,
    jump,
    aluop
);

aludec ad(
    funct,
    aluop,
    alucontrol
);

assign pcsrc = branch & zero;

always @(branch, zero) begin
    $display("Controller:\n \tBranch: %b\n\tZero: %b", branch, zero);
end

endmodule
