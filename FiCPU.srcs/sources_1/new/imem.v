`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2022 02:32:46 PM
// Design Name: 
// Module Name: imem
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


module imem (
    input [5:0] a,
    output [31:0] rd
);

reg [31:0] RAM[63:0];

initial
    begin
        $readmemh ("memfile.dat",RAM);
    end
    

assign rd = RAM[a]; // word aligned

endmodule
