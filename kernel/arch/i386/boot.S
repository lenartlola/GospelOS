# Multuboot set
# https://stackoverflow.com/questions/34183799/how-does-this-assembly-bootloader-code-work

.set MAGIC, 0x1BADB002
.set FLAGS, 0
.set CHECKSUM, -(MAGIC + FLAGS)

.section .multiboot
  .long MAGIC
  .long FLAGS
  .long CHECKSUM
  

.section .text
.extern	kernel_entry
.global _start

_start:
  mov   $kernel_stack, %esp
  push  %eax
  push  %ebx
  call  kernel_entry

_halt:
  cli
  hlt
  jmp _halt

.section .bss
.space 2097152 # 2 MiB space inside the Ram to the stack pointer

kernel_stack: 

