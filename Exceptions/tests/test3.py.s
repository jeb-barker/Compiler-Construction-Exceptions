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
  movq $6, %rsi
  movq $8, %rdx
  callq add_if
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
add_ifstart:
  movq %rdi, %rbx
  movq %rsi, %r12
  movq %rdx, %r13
  movq %rbx, %rax
  addq %r12, %rax
  movq %rax, %rbx
  movq %rbx, %rax
  addq %r13, %rax
  movq %rax, %rbx
  movq %rbx, %rax
  jmp add_if_conclusion
  movq $0, %rax
  jmp add_if_conclusion
add_if:
  pushq %rbp
  movq %rsp, %rbp
  subq $0, %rsp
  pushq %rbx
  pushq %r12
  pushq %r13
  pushq %r14
  jmp add_ifstart
add_if_conclusion:
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