try:
    print(1)
    try:
        raise 5
    except:
        print(12)
except:
    print(5)
