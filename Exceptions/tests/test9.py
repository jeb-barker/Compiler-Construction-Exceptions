def value_finder(n: int, tup: int) -> int:
    try:
        while n < 100:
            if n == tup:
                raise n
            n = n + 1
    except:
        return n

    return 0


print(value_finder(90, 70))
x = 5
try:
    print(5)
except:
    print(1)
try:
    if x == 5:
        raise 1
        raise 2
except:
    print(x)