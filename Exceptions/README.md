## Try-Except Blocks and Raise Statements
- Adds two Statements in the language, a TryExcept block and a Raise Statement
- For instance, the following program would print '2' because an Exception is raised before '1' can be printed
```python
try:
    raise 5
    print(1)
except:
    print(2)
```

- try-except blocks do not work across scope boundaries such as functions. This would be a great extension to this project
- Exceptions aren't actually raised, and instead just moves the execution to the except block, functionally making a raise statement like a break statement
  - for instance, this is what python Exceptions typically look like, where the Exception is like a dataclass.
```python
try:
    raise Exception('failed test')
except Exception as e:
    print(e)

```
- My implementation does not work this way, and instead works more like a break statement
  - This offers the programmer a way to break out of while loops (see test 10)

- 10 test cases are included and can be run with run_tests.py
