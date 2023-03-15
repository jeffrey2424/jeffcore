OUTPUT_TEMPLATE = """
section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    negativeFlag resb 1

section .text
    global _start
 
_start:
    $CONFIGURED_COMMANDS

    mov rax, 60
    mov rdi, 0
    syscall
 
 
_printInt:
    mov rcx, digitSpace
    mov rbx, 10
    mov [rcx], rbx
    inc rcx
    mov [digitSpacePos], rcx

    cmp rax, 0
    jg _printIntLoop

    mov dl, 0x01
    mov rcx, negativeFlag
    mov [rcx], dl

    mov rcx, negativeFlag
    mov rcx, [negativeFlag]

    neg rax
    

 
_printIntLoop:
    mov rdx, 0
    mov rbx, 10
    div rbx
    push rax
    add rdx, 48
 
    mov rcx, [digitSpacePos]
    mov [rcx], dl
    inc rcx
    mov [digitSpacePos], rcx
    
    pop rax
    cmp rax, 0
    jne _printIntLoop

    mov rcx, [negativeFlag]
    cmp rcx, 0x01
    jne _printIntLoopPrinter

    mov dl, 0x2d
    mov rcx, [digitSpacePos]
    mov [rcx], dl
    inc rcx
    mov [digitSpacePos], rcx
 
_printIntLoopPrinter:
    mov rcx, [digitSpacePos]
 
    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall
 
    mov rcx, [digitSpacePos]
    dec rcx
    mov [digitSpacePos], rcx
 
    cmp rcx, digitSpace
    jge _printIntLoopPrinter
 
    ret
"""