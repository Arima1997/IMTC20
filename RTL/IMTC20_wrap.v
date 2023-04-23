//Modulo TOP LEVEL del proyecto
// En este modulo se realizaran todas las conexiones entre los componentes
// del procesador, y se generaran las salidas y entradas correspondientes.
module IMTC20_wrap #(parameter D_WIDTH = 8, A_WIDTH = 10)(CLK, ARST, CE, Data_bus, Addr_bus, RW);
input wire CLK, ARST, CE;
inout [D_WIDTH-1:0] Data_bus;
output [A_WIDTH-1:0] Addr_bus;
output RW;

/*********    Creacion de los cables de interconexión de componentes    *********/

//MUX3
wire S0M3, S1M3;
wire [D_WIDTH-1:0] MUX3o;
//MUX2 y MUX1
wire S0M1;
wire [A_WIDTH-1:0] MUX2o, MUX1o;
//MBR
wire MBRce;
wire [D_WIDTH-1:0]MBRo;
//PC
wire [D_WIDTH-1:0] PCLo;
wire [1:0] PCHo;
//sp
wire [A_WIDTH-1:0] SPo;
//MAR
wire MARce;
wire [A_WIDTH-1:0] MARo;
//IR
wire [3:0] IRo;
//MBRaux
wire [1:0] MBRauxo;
//CCR
wire CCRZo, CCRCo;
//ACC
wire [D_WIDTH-1:0] ACCo;
//ALU
wire [D_WIDTH-1:0] ALUo;
wire Zalu, Calu;
//CONTADOR
wire [3:0] CNTo;
//Unidad de control UC
wire [19:0] X;

/********* Creación de los modulos registro del procesador *********/
assign Addr_bus = MARo;
assign RW = X[19];

assign MBRce    = X[1] || X[2] || X[3] || X[4];
assign S0M3     = X[2] || X[4];
assign S1M3     = X[3] || X[4];
assign S0M1     = X[8] || X[9];
assign MARce    = X[7] || X[8] || X[9];

//Combinacionales
UC Ctrl_Unt(
    .C(CCRCo),
    .Z(CCRZo),
    .Q(IRo),
    .T(CNTo),
    .X0(X[0]),
    .X1(X[1]),
    .X2(X[2]),
    .X3(X[3]),
    .X4(X[4]),
    .X5(X[5]),
    .X6(X[6]),
    .X7(X[7]),
    .X8(X[8]),
    .X9(X[9]),
    .X10(X[10]),
    .X11(X[11]),
    .X12(X[12]),
    .X13(X[13]),
    .X14(X[14]),
    .X15(X[15]),
    .X16(X[16]),
    .X17(X[17]),
    .X18(X[18]),
    .X19(X[19])
    );

ALU Arith_Unit0(
    .S0(X[15]),
    .S1(X[16]),
    .S2(X[17]),
    .ACC(ALUo),
    .MBR(MBRo),
    .Cin(CCRCo),
    .RESULT(ALUo),
    .C(Calu),
    .Z(Zalu)
    );

TRIST #(.D_WIDTH(D_WIDTH)) MBR_tri(
    .RW(RW),
    .IN(MBRo),
    .OUT(Data_bus)
    );

//Multiplexores
MUX4_1 Mux3(
    .S0(S0M3),
    .S1(S1M3),
    .ACC(ACCo),
    .DLEC(Data_bus),
    .PCL(PCLo),
    .PCH(PCHo),
    .SAL(MUX3o)
    );
    
MUX2_1 #(.BUS_WIDTH(A_WIDTH)) Mux2(
    .SEL(X[9]),
    .A({PCLo, PCHo}),
    .B(SPo),
    .OUT(MUX2o)
    );

MUX2_1 #(.BUS_WIDTH(A_WIDTH)) Mux1(
    .SEL(S0M1),
    .A({MBRo, MBRauxo}),
    .B(MUX2o),
    .OUT(MUX1o)
    );

//Registros
Param_reg #(.D_WIDTH(D_WIDTH)) MBR_reg(
    .CLK(CLK),
    .ARST(ARST),
    .LOAD(MBRce),
    .IN(MUX3o),
    .OUT(MBRo)
    );

Param_reg #(.D_WIDTH(A_WIDTH)) MAR_reg(
    .CLK(CLK),
    .ARST(ARST),
    .LOAD(MARce),
    .IN(MUX1o),
    .OUT(MARo)
    );

Param_reg #(.D_WIDTH(D_WIDTH)) ACC_reg(
    .CLK(CLK),
    .ARST(ARST),
    .LOAD(X[18]),
    .IN(ALUo),
    .OUT(ACCo)
    );

Param_reg #(.D_WIDTH(4)) IR_reg(
    .CLK(CLK),
    .ARST(ARST),
    .LOAD(X[0]),
    .IN(MBRo[3:0]),
    .OUT(IRo)
    );

Param_reg #(.D_WIDTH(2)) MBRaux_reg(
    .CLK(CLK),
    .ARST(ARST),
    .LOAD(X[10]),
    .IN(MBRo[1:0]),
    .OUT(MBRauxo)
    );

Param_reg #(.D_WIDTH(2)) CCR_reg(
    .CLK(CLK),
    .ARST(ARST),
    .LOAD(X[18]),
    .IN({Zalu, Calu}),
    .OUT({CCRZo, CCRCo})
    );

//Counters
Counter_reg #(.WIDTH(A_WIDTH)) Stack_Ptr(
    .CLK(CLK),
    .ARST(ARST),
    .SRST(1'b0),
    .INC(X[12]),
    .DEC(X[13]),
    .CE(CE),
    .LOAD(X[11]),
    .IN({2'b10, MBRo}),
    .T(SPo)
    );

Counter_reg #(.WIDTH(4)) Cnt(
    .CLK(CLK),
    .ARST(ARST),
    .SRST(X[14]),
    .INC(1'b1),
    .DEC(1'b0),
    .CE(CE),
    .LOAD(1'b0),
    .IN(4'b0),
    .T(CNTo)
    );

Counter_reg #(.WIDTH(A_WIDTH)) PC_reg(
    .CLK(CLK),
    .ARST(ARST),
    .SRST(1'b0),
    .INC(X[6]),
    .DEC(1'b0),
    .CE(CE),
    .LOAD(X[5]),
    .IN({MBRauxo, MBRo}),
    .T({PCLo, PCHo})
    );

endmodule