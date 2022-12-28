# for i in range(4):
#     print("parameter[0:7]", end=" ")
#     for j in range(8):
#         print("S%02d=8\'d%d"%(i*9+j, i*9+j), end=", ")
#     print("S%02d=8\'d%d"%(i*9+8, i*9+8), end=";\n")

k = 0
for i in range(4): 
    print("assign {a%d0, a%d1, a%d2, a%d3} = {mem[ADDR_A%d0], mem[ADDR_A%d1], mem[ADDR_A%d2], mem[ADDR_A%d3]};"%(i, i, i, i, i, i, i, i))
    #for j in range(4):
        #print("parameter[4:0] ADDR_A%d%d = 5'd%d;"%(i, j, k))
        #k = k + 1

for i in range(3): 
    for j in range(3):
        print("parameter[4:0] ADDR_B%d%d = 5'd%d;"%(i, j, k))
        k = k + 1

for i in range(2): 
    for j in range(2):
        print("parameter[4:0] ADDR_C%d%d = 5'd%d;"%(i, j, k))
        k = k + 1