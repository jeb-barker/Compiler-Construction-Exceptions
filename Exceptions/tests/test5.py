print(1)
try:
    print(2)
    raise 2
    print(3)
except:
    print(4)
    try:
        print(5)
        raise 5
        print(6)
    except:
        print(7)
    print(8)
print(9)
