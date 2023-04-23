//Modulo del registro MBR
module Param_reg #(parameter D_WIDTH = 8)(CLK, ARST, LOAD, IN, OUT);
input CLK, ARST, LOAD;
input [D_WIDTH-1:0] IN;
output reg [D_WIDTH-1:0] OUT;

always @(posedge CLK or posedge ARST)
begin
	if (ARST==1) OUT <= 0;
	else if (LOAD == 1) OUT <= IN;
end

endmodule
