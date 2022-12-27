for i in range(4):
    print("parameter[0:7]", end=" ")
    for j in range(8):
        print("S%02d=8\'d%d"%(i*9+j, i*9+j), end=", ")
    print("S%02d=8\'d%d"%(i*9+8, i*9+8), end=";\n")