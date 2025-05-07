  .globl main
mainstart:
  jmp label_1
label_1:
  movq $5, %rdi
  callq print_int
  movq $5, %rax
  jmp label_2
  movq $2, %rdi
  callq print_int
  jmp label_3
label_2:
  movq $1, %rdi
  callq print_int
  jmp label_3
label_3:
  movq $0, %rax
  jmp mainconclusion
main:
  pushq %rbp
  movq %rsp, %rbp
  pushq %rbx
  pushq %r12
  pushq %r13
  pushq %r14
  subq $0, %rsp
  movq $16384, %rdi
  movq $16, %rsi
  callq initialize
  movq rootstack_begin(%rip), %r15
  jmp mainstart
mainconclusion:
  addq $0, %rsp
  subq $0, %r15
  popq %r14
  popq %r13
  popq %r12
  popq %rbx
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
