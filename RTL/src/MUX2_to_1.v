module MUX2_1 #(parameter BUS_WIDTH = 8)(SEL, A, B, OUT);
input SEL;
input [BUS_WIDTH-1:0] A;
input [BUS_WIDTH-1:0] B;
output reg [BUS_WIDTH-1:0] OUT;

always @(*)
begin
	case (SEL)
	1'b0: OUT = A;
	1'b1: OUT = B;
	endcase
end

endmodule
