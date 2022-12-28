for i in range(4):
    print("assign {a%d0, a%d1, a%d2, a%d3} = {mem[ADDR_A%d0], mem[ADDR_A%d1], mem[ADDR_A%d2], mem[ADDR_A%d3]};"%(i, i, i, i, i, i, i, i))

for i in range(3):
    print("assign {b%d0, b%d1, b%d2} = {mem[ADDR_B%d0], mem[ADDR_B%d1], mem[ADDR_B%d2]};"%(i, i, i, i, i, i))

for i in range(2):
    print("assign {c%d0, c%d1} = {mem[ADDR_C%d0], mem[ADDR_C%d1]};"%(i, i, i, i))
