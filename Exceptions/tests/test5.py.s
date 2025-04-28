  .globl main
mainstart:
  pushq %rdx
  pushq %rcx
  pushq %rsi
  pushq %rdi
  pushq %r8
  pushq %r9
  pushq %r10
  movq $10, %rdi
  callq fib
  popq %rdx
  popq %rcx
  popq %rsi
  popq %rdi
  popq %r8
  popq %r9
  popq %r10
  movq %rax, %rbx
  movq %rbx, %rdi
  callq print_int
  movq $0, %rax
  jmp main_conclusion
main:
  pushq %rbp
  movq %rsp, %rbp
  subq $0, %rsp
  movq $16384, %rdi
  movq $16, %rsi
  callq initialize
  movq rootstack_begin(%rip), %r15
  pushq %rbx
  pushq %r12
  pushq %r13
  pushq %r14
  jmp mainstart
main_conclusion:
  popq %rbx
  popq %r12
  popq %r13
  popq %r14
  addq $0, %rsp
  popq %rbp
  subq $0, %r15
  retq
fibstart:
  movq %rdi, %rbx
  cmpq $1, %rbx
  setle %al
  movzbq %al, %r12
  cmpq $1, %r12
  je fibl_9
  jmp fibl_10
fibl_9:
  movq %rbx, %rax
  jmp fib_conclusion
  jmp fibl_8
fibl_10:
  movq %rbx, %rax
  subq $1, %rax
  movq %rax, %r12
  pushq %rdx
  pushq %rcx
  pushq %rsi
  pushq %rdi
  pushq %r8
  pushq %r9
  pushq %r10
  movq %r12, %rdi
  callq fib
  popq %rdx
  popq %rcx
  popq %rsi
  popq %rdi
  popq %r8
  popq %r9
  popq %r10
  movq %rax, %r12
  movq %rbx, %rax
  subq $2, %rax
  movq %rax, %rbx
  pushq %rdx
  pushq %rcx
  pushq %rsi
  pushq %rdi
  pushq %r8
  pushq %r9
  pushq %r10
  movq %rbx, %rdi
  callq fib
  popq %rdx
  popq %rcx
  popq %rsi
  popq %rdi
  popq %r8
  popq %r9
  popq %r10
  movq %rax, %rbx
  movq %r12, %rax
  addq %rbx, %rax
  movq %rax, %rbx
  movq %rbx, %rax
  jmp fib_conclusion
  jmp fibl_8
fibl_8:
  movq $0, %rax
  jmp fib_conclusion
fib:
  pushq %rbp
  movq %rsp, %rbp
  subq $0, %rsp
  pushq %rbx
  pushq %r12
  pushq %r13
  pushq %r14
  jmp fibstart
fib_conclusion:
  popq %rbx
  popq %r12
  popq %r13
  popq %r14
  addq $0, %rsp
  popq %rbp
  retq
allocate:
      movq free_ptr(%rip), %rax
      addq %rdi, %rax
      movq %rdi, %rsi
      cmpq fromspace_end(%rip), %rax
      jl allocate_alloc
      movq %r15, %rdi
      callq collect
      jmp allocate_alloc
allocate_alloc:
      movq free_ptr(%rip), %rax
      addq %rsi, free_ptr(%rip)
      retq