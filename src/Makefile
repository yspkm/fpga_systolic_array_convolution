CC = iverilog
SS = gtkwave
#MODULES = pe.v
#TB = tb_pe.v
MODULES = pe.v filter_serial.v
TB = tb_filter_serial.v
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