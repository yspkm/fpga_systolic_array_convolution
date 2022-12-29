
A = [[9,8,2,6],
    [0,4,1,6],
    [4,10,1,1],
    [2,2,9,9]]

B = [[3,2,0],
    [2,0,1],
    [3,1,1]]

C = [[0,0],
     [0,0]]

print("\n// for declaration") 
print("parameter[7:0]", end="")
for i in range(4):
    print("\n\t", end="")
    for j in range(4):
        if (i == 3 and j == 3):
            print("INPUT_A%d%d=8'd%d"%(i, j, A[i][j]), end=';\n')
        else:
            print("INPUT_A%d%d=8'd%d"%(i, j, A[i][j]), end=',')

print("\nparameter[7:0]", end="")
for i in range(3):
    print("\n\t", end="")
    for j in range(3):
        if (i == 2 and j == 2):
            print("INPUT_B%d%d=8'd%d"%(i, j, B[i][j]), end=';\n')
        else:
            print("INPUT_B%d%d=8'd%d"%(i, j, B[i][j]), end=',')

print("\nreg[7:0]", end="")
for i in range(4):
    print("\n\t", end="")
    for j in range(4):
        if (i == 3 and j == 3):
            print("INIT_A%d%d"%(i, j), end=';\n')
        else:
            print("INIT_A%d%d"%(i, j), end=',')

print("\nreg[7:0] ", end="")
for i in range(3):
    print("\n\t", end="")
    for j in range(3):
        if (i == 2 and j == 2):
            print("INIT_B%d%d"%(i, j), end=';\n')
        else:
            print("INIT_B%d%d"%(i, j), end=',')

print("\n// storage entries")             
for i in range(4):
    for j in range(4):
        print("uint8 addr_a%d%d(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A%d%d), .out(a%d%d));"%(i, j, i, j, i, j))
for i in range(3):
    for j in range(3):
        print("uint8 addr_b%d%d(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B%d%d), .out(b%d%d));"%(i, j, i, j, i, j))

print("\n//for initial block in ram.v")
print("// init data")
for i in range(4):
    for j in range(4):
        print("INIT_A%d%d<=INPUT_A%d%d"%(i, j, i, j), end=';')
    print()
print("\n// init filter")
for i in range(3):
    for j in range(3):
        print("INIT_B%d%d<=INPUT_B%d%d"%(i, j, i, j), end=';')
    print()

for i in range(3):
    B[i].reverse()
B.reverse()
for i0 in range(2):
    for j0 in range(2):
        C[i0][j0] = 0
        for i in range(3):
            for j in range(3):
                C[i0][j0] += A[i+i0][j+j0] * B[i][j]
for i in range(3):
    B[i].reverse()
B.reverse()

print("// lcd.v")
print("\n // answer")
for i in range(2):
    for j in range(2):
        print("parameter [7:0] ANS_C%d%d=8'd%d;"%(i, j, C[i][j]))

