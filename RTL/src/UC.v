//Modulo de la Unidad de Control del procesador, UC
module UC (C, Z, Q, T, X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19);
input C, Z;
input [3:0] Q, T;
output X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19;


parameter T0 = 4'h0;
parameter T1 = 4'h1;
parameter T2 = 4'h2;
parameter T3 = 4'h3;
parameter T4 = 4'h4;
parameter T5 = 4'h5;
parameter T6 = 4'h6;
parameter T7 = 4'h7;
parameter T8 = 4'h8;
parameter T9 = 4'h9;
parameter TA = 4'hA;
parameter TB = 4'hB;
parameter TC = 4'hC;
parameter TD = 4'hD;
parameter TE = 4'hE;
parameter TF = 4'hF;

parameter Q0 = 4'h0;
parameter Q1 = 4'h1;
parameter Q2 = 4'h2;
parameter Q3 = 4'h3;
parameter Q4 = 4'h4;
parameter Q5 = 4'h5;
parameter Q6 = 4'h6;
parameter Q7 = 4'h7;
parameter Q8 = 4'h8;
parameter Q9 = 4'h9;
parameter QA = 4'hA;
parameter QB = 4'hB;
parameter QC = 4'hC;
parameter QD = 4'hD;
parameter QE = 4'hE;
parameter QF = 4'hF;

//Comienzan las asignaciones de las lineas de control

//IR<=MBR
assign X0 = (T==T2)? 1'b1 : 1'b0;

//MBR<=ACC
assign X1 = (T==T9 && Q==QA)? 1'b1 : 1'b0;

//MBR<=DLect
assign X2 = (T==T1)||(T==T4 && Q==Q0)||(T==T4 && Q==Q2)||(T==T7 && Q==Q2)||(T==T9 && Q==Q2)||(T==T4 && Q==Q3)||
		(T==T7 && Q==Q3)||(T==T9 && Q==Q3)||(T==T4 && Q==Q9)||(T==T4 && Q==QA)||(T==T7 && Q==QA)||(T==T7 && Q==QC)||
		(T==T4 && Q==Q1)||(T==T7 && Q==Q1)||(T==T9 && Q==Q1)||(T==T4 && Q==QB)||(T==TA && Q==QE)||
		(T==T7 && Q==QB)||(T==T4 && Q==Q4)||(T==T4 && Q==Q6)||(T==T7 && Q==Q6)||(T==T5 && Q==QF)||(T==T7 && Q==QF)||
		(T==T9 && Q==Q6)||(T==T4 && Q==QC)||(T==T4 && Q==QD)||(T==T7 && Q==QD)||(T==T8 && Q==QE)? 1'b1 : 1'b0;
		
//MBR<=PCL
assign X3 = (T==T3 && Q==QE)? 1'b1 : 1'b0;

//MBR<=PCH
assign X4 = (T==T5 && Q==QE)? 1'b1 : 1'b0;

//PC<=MBRaux:MBR
assign X5 = (T==T8 && Q==QB)||(T==TB && Q==QE)||(T==T8 && Q==QF)||
		(T==T8 && Q==QC && C==1'b1)||(T==T8 && Q==QD && Z==1'b1)? 1'b1 : 1'b0;
		
//PC<=PC+1
assign X6 = (T==T1)||(T==T4 && Q==Q0)||(T==T4 && Q==Q2)||(T==T7 && Q==Q2)||(T==T4 && Q==Q3)||(T==T7 && Q==Q3)||
		(T==T4 && Q==Q9)||(T==T4 && Q==QA)||(T==T7 && Q==QA)||(T==T4 && Q==Q1)||(T==T7 && Q==Q1)||(T==T4 && Q==QB)||
		(T==T7 && Q==QB)||(T==T4 && Q==Q4)||(T==T4 && Q==Q6)||(T==T7 && Q==Q6)||(T==T8 && Q==QE)||
		(T==T4 && Q==QC)||(T==T7 && Q==QC)||(T==T4 && Q==QD)||(T==T7 && Q==QD)||(T==T9 && Q==QF)||
		(T==TA && Q==QF)? 1'b1 : 1'b0;
		
//MAR<--MBRaux&MBR
assign X7 = (T==T8 && Q==Q2) || (T==T8 && Q==Q3) || (T==T8 && Q==QA) || (T==T8 && Q==Q1) ||
				(T==T8 && Q==Q6)? 1'b1 : 1'b0;
					
//MAR<--PC
assign X8 = (T==T0) || (T==T3 && Q==Q2) || (T==T3 && Q==Q0) || (T==T3 && Q==Q3) ||
		(T==T6 && Q==Q3) || (T==T3 && Q==Q9) || (T==T3 && Q==QA) || (T==T6 && Q==QA) || 
		(T==T3 && Q==Q1) || (T==T6 && Q==Q1) || (T==T3 && Q==QB) || (T==T6 && Q==QB) || 
		(T==T3 && Q==Q4) || (T==T3 && Q==Q6) || (T==T6 && Q==Q6) || (T==T9 && Q==QE) ||
		(T==T3 && Q==QC) || (T==T6 && Q==QC) || (T==T3 && Q==QD) || (T==T6 && Q==QD) ||
		(T==T6 && Q==Q2)||(T==T7 && Q==QE)? 1'b1 : 1'b0;

//MAR<--SP
assign X9 =(T==T3 && Q==QE)||(T==T5 && Q==QE)||(T==T4 && Q==QF)||(T==T6 && Q==QF)? 1'b1 : 1'b0;

//MBRaux<--MBR(1,0)
assign X10 = (T==T5 && Q==Q2)||(T==T5 && Q==Q3)||(T==T5 && Q==QA) ||(T==T9 && Q==QE)||
					(T==T5 && Q==Q1)||(T==T5 && Q==QB)|| (T==T5 && Q==Q6)||(T==T6 && Q==QF)||
					(T==T5 && Q==QC)||(T==T5 && Q==QD)? 1'b1 : 1'b0;

//SP<--CTE&MBR
assign X11 = (T==T5 && Q==Q9)? 1'b1 : 1'b0;

//SP<-- SP+1
assign X12 =(T==T3 && Q==QF)||(T==T5 && Q==QF)? 1'b1 : 1'b0;

//SP<--SP-1
assign X13 =(T==T4 && Q==QE)||(T==T6 && Q==QE)? 1'b1 : 1'b0;

//T<--0
assign X14 = (T==T6 && Q==Q0)||(T==TB && Q==Q2)||(T==T4 && Q==Q7)||(T==T9 && Q==QD)|| 
		(T==T4 && Q==Q8)||(T==TB && Q==Q3)||(T==T4 && Q==Q5)||(T==T6 && Q==Q9)|| 
		(T==TB && Q==QA)||(T==TB && Q==Q1)||(T==T9 && Q==QB)||(T==TC && Q==QE)||
		 (T==T6 && Q==Q4)||(T==TB && Q==Q6)||(T==T9 && Q==QC)||(T==TB && Q==QF)||
		(T==T8 && Q==QC && C==1'b0)||(T==T8 && Q==QD && Z==1'b0)? 1'b1 : 1'b0;

//ALU<--f(X15,X16,X17)
assign X15= (T==T3 && Q==Q7)||(T==TA && Q==Q6)||(T==T5 && Q==Q4)||(T==TA && Q==Q2)?  1'b1 : 1'b0;
assign X16= (T==T3 && Q==Q7)||(T==T5 && Q==Q4)||(T==T3 && Q==Q8)||(T==T3 && Q==Q5)?  1'b1 : 1'b0;
assign X17= (T==T3 && Q==Q7)||(T==TA && Q==Q6)||(T==TA && Q==Q3)||(T==T3 && Q==Q8)?  1'b1 : 1'b0;

//ACC<--ALU , CCR<--flags
assign X18 = (T==T5 && Q==Q0)||(T==TA && Q==Q2)||(T==T3 && Q==Q5)||(T==TA && Q==Q3)||(T==T3 && Q==Q7)|| 
		(T==T3 && Q==Q8)||(T==T8 && Q==Q5)||(T==TA && Q==Q1)|| 
		(T==T5 && Q==Q4)||(T==TA && Q==Q6)?  1'b1 : 1'b0;

// R/W'
assign X19 = (T==TA && Q==QA)||(T==T4 && Q==QE)||(T==T6 && Q==QE)? 1'b0 : 1'b1;


endmodule
