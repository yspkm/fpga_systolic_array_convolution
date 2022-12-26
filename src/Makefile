CC = iverilog
SS = gtkwave
MODULES = pe.v
TB = tb_pe.v
OBJ = ${MODULES} ${TB}

EXE = a.out
VCD = output.vcd

${VCD}: ${EXE}
	./${EXE}
	${SS} ${VCD}

${EXE}: ${OBJ}
	${CC} ${OBJ}

clean: 
	rm ${EXE} ${VCD}