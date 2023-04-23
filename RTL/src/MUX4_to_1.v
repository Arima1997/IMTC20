//Modulo del multiplexor de 4 a 1
module MUX4_1 (S0, S1, ACC, DLEC, PCL, PCH, SAL);
input S0, S1;
input [7:0] ACC, DLEC, PCL;
input [1:0] PCH;
output reg [7:0] SAL;

always @(*)
begin
	case ({S1,S0})
	0: SAL = ACC;
	1: SAL = DLEC;
	2: SAL = PCL;
	3: SAL = {6'b000000,PCH};
	endcase
end

endmodule

