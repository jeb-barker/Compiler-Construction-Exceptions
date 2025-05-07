  .globl main
except_if_1start:
  movq %rdi, %r8
  jmp label_3
label_3:
  cmpq $1, %r8
  sete %al
  movzbq %al, %r8
  movq $1, %rax
  cmpq %r8, %rax
  je label_6
  jmp label_7
label_4:
  movq $0, %rax
  jmp except_if_1conclusion
  jmp label_5
label_5:
  movq $0, %rax
  jmp except_if_1conclusion
label_6:
  movq $1, %rax
  jmp label_4
  jmp label_8
label_7:
  jmp label_8
label_8:
  jmp label_5
except_if_1:
  pushq %rbp
  movq %rsp, %rbp
  pushq %rbx
  pushq %r12
  pushq %r13
  pushq %r14
  subq $0, %rsp
  jmp except_if_1start
except_if_1conclusion:
  addq $0, %rsp
  subq $0, %r15
  popq %r14
  popq %r13
  popq %r12
  popq %rbx
  popq %rbp
  retq
mainstart:
  jmp label_9
label_9:
  pushq %rdx
  pushq %rcx
  pushq %rsi
  pushq %rdi
  pushq %r8
  pushq %r9
  pushq %r10
  movq $1, %rdi
  callq except_if_1
  popq %r10
  popq %r9
  popq %r8
  popq %rdi
  popq %rsi
  popq %rcx
  popq %rdx
  movq %rax, %r8
  movq %r8, %r8
  jmp label_11
label_10:
  movq $1, %rdi
  callq print_int
  jmp label_11
label_11:
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
