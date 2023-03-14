section .text
    global _start
 
_start:
    mov rax, 6
    inc rax
    add rax, 0x30

    mov rsi, rax
    mov rax, 1
    mov rdi, 1
    mov rdx, 1
    syscall

    mov rax, 60
    mov rdi, 0
    syscall