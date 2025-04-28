  .globl main
mainstart:
  pushq %rdx
  pushq %rcx
  pushq %rsi
  pushq %rdi
  pushq %r8
  pushq %r9
  pushq %r10
  movq $5, %rdi
  callq fact
  popq %rdx
  popq %rcx
  popq %rsi
  popq %rdi
  popq %r8
  popq %r9
  popq %r10
  movq %rax, %rdx
  movq %rdx, %rdi
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
factstart:
  movq %rdi, %rdx
  cmpq $0, %rdx
  sete %al
  movzbq %al, %rcx
  cmpq $1, %rcx
  je factl_7
  jmp factl_8
factl_7:
  movq $1, %rax
  jmp fact_conclusion
  jmp factl_6
factl_8:
  movq %rdx, %rax
  subq $1, %rax
  movq %rax, %rcx
  pushq %rdx
  pushq %rcx
  pushq %rsi
  pushq %rdi
  pushq %r8
  pushq %r9
  pushq %r10
  movq %rcx, %rdi
  callq fact
  popq %rdx
  popq %rcx
  popq %rsi
  popq %rdi
  popq %r8
  popq %r9
  popq %r10
  movq %rax, %rcx
  movq %rdx, %rax
  imulq %rcx, %rax
  movq %rax, %rdx
  movq %rdx, %rax
  jmp fact_conclusion
  jmp factl_6
factl_6:
  movq $0, %rax
  jmp fact_conclusion
fact:
  pushq %rbp
  movq %rsp, %rbp
  subq $0, %rsp
  pushq %rbx
  pushq %r12
  pushq %r13
  pushq %r14
  jmp factstart
fact_conclusion:
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