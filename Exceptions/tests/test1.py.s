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
  callq add1
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
mainmain:
  pushq %rbp
  movq %rsp, %rbp
  subq $0, %rsp
  movq $16384, %rdi
  movq $16, %rsi
  callq initialize
  movq rootstack_begin(%rip), %r15
  jmp mainstart
main_conclusion:
  addq $0, %rsp
  popq %rbp
  subq $0, %r15
  retq
add1start:
  movq %rdi, %rdx
  movq %rdx, %rax
  addq $1, %rax
  movq %rax, %rdx
  movq %rdx, %rax
  jmp add1_conclusion
  movq $0, %rax
  jmp add1_conclusion
add1main:
  pushq %rbp
  movq %rsp, %rbp
  subq $0, %rsp
  pushq %rbx
  pushq %r12
  pushq %r13
  pushq %r14
  jmp add1start
  popq %rbx
  popq %r12
  popq %r13
  popq %r14
add1_conclusion:
  addq $0, %rsp
  popq %rbp
  subq $0, %r15
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