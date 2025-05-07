def except_if_1(n: int) -> int:
    try:
        if n == 1:
            raise 1
    except:
        return 0

try:
    a = except_if_1(1)
except:
    print(1)
