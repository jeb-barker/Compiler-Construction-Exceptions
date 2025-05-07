def value_finder(n: int, tup: int) -> int:
    try:
        while n < 100:
            if n == tup:
                raise n
            n = n + 1
    except:
        return n

    return 0


print(value_finder(90, 98))