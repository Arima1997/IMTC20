module Counter_reg #(parameter WIDTH = 4)(CLK, ARST, SRST, INC, DEC, CE, LOAD, IN, T);
input CLK, ARST, SRST;
input LOAD, INC, DEC, CE;
input [WIDTH-1:0] IN;
output reg [WIDTH-1:0] T;

always @(posedge CLK or posedge ARST)
begin
	if (ARST == 1'b1) T <= 0;
	else if (SRST == 1'b1) T <= 0;
	else if (CE == 1'b1 && LOAD == 1'b1) T <= IN;
	else if (CE == 1'b1 && DEC == 1'b1) T <= T - 1'h1;
	else if (CE == 1'b1 && INC == 1'b1) T <= T + 1'h1;
	else T <= T;
end 

endmodule
