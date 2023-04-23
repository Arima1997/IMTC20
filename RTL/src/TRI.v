//Modulo de un triestado para el bus de datos, TRI
module TRIST #(parameter D_WIDTH = 8)(RW, IN, OUT);
input RW;
input [D_WIDTH-1:0]IN;
output [D_WIDTH-1:0]OUT;

assign OUT = RW ? {D_WIDTH{1'bz}}:IN;

endmodule
