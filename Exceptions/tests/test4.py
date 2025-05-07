def add1_and2(n: int) -> (int, int):
    return (n + 1, n + 2)

try:
    z = add1_and2(5)
    print(z[0])
    print(z[1])
except:
    print(0)
