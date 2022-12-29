CC = iverilog
SS = gtkwave

BIN = a.out
VCD = output.vcd

ADD = addu10.v addu8.v addu6.v addu4.v fadder.v hadder.v
MULT = multu8.v vedic_multu2.v vedic_multu4.v vedic_multu8.v
REG = uint8.v flipflop.v 
COMP = sa2x2.v pe.v
MODULE =  ${COMP} ${MULT} ${ADD} ${REG} 

TB = tb_sa2x2.v  
OBJ = ${TB} ${MODULE}

${VCD}: ${BIN} 
	./${BIN}
	${SS} ${VCD}

${BIN}: ${OBJ}
	${CC} ${OBJ} 

clean:
	rm ${VCD} ${BIN}