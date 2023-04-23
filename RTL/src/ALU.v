//Modulo Aritmethic Logic Unit
module ALU (S0, S1, S2, ACC, MBR, Cin, RESULT, C, Z);
input S0, S1, S2, Cin;
input [7:0] ACC, MBR;
output [7:0] RESULT;
output C, Z;

wire [8:0] ACC1, MBR1;
reg [8:0]TEMP;

assign MBR1 = {1'b0, MBR};
assign ACC1 = {1'b0, ACC};


always @(*)
	begin
		case ({S2,S1,S0})
			3'b000: TEMP <= MBR1;
			3'b001: TEMP <= ACC1 + MBR1 + Cin;
			3'b010: TEMP <= {1'b0, ~ACC};
			3'b011: TEMP <= ACC1|MBR1;
			3'b100: TEMP <= ACC1&MBR1;
			3'b101: TEMP <= ACC1^MBR1;
			3'b110: TEMP <= {ACC[0],1'b0,ACC[7:1]};
			3'b111: TEMP <= {ACC, 1'b0};
		endcase
	end
assign Z = (TEMP[7:0] == 8'b00000000)?  1'b1:1'b0;
assign C = TEMP[8];
assign RESULT = TEMP[7:0];

endmodule
