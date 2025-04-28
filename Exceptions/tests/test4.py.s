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
  callq add1_and2
  popq %rdx
  popq %rcx
  popq %rsi
  popq %rdi
  popq %r8
  popq %r9
  popq %r10
  movq %rax, %rbx
  movq %rbx, %rbx
  movq %rbx, %r11
  movq 8(%r11), %r12
  movq %r12, %rdi
  callq print_int
  movq %rbx, %r11
  movq 16(%r11), %rbx
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
add1_and2start:
  movq %rdi, %rbx
  movq %rbx, %rax
  addq $1, %rax
  movq %rax, %r12
  movq %rbx, %rax
  addq $2, %rax
  movq %rax, %rbx
  movq $24, %rdi
  callq allocate
  movq %rax, %r11
  movq $5, 0(%r11)
  movq %r12, 8(%r11)
  movq %rbx, 16(%r11)
  movq %r11, %rbx
  movq %rbx, %rax
  jmp add1_and2_conclusion
  movq $0, %rax
  jmp add1_and2_conclusion
add1_and2:
  pushq %rbp
  movq %rsp, %rbp
  subq $0, %rsp
  pushq %rbx
  pushq %r12
  pushq %r13
  pushq %r14
  jmp add1_and2start
add1_and2_conclusion:
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