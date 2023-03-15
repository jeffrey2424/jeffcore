
section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    negativeFlag resb 1

section .text
    global _start
 
_start:
    
	; start 3
	mov rax, 3
	push rax

	; add 2
	pop rax
	add rax, 2
	push rax

	; divide 4
	pop rax
	mov rdx, 0
	mov rbx, 4
	idiv rbx
	push rax

	; add 17
	pop rax
	add rax, 17
	push rax

	; multiply 39
	pop rax
	imul rax, 39
	push rax

	; divide 2
	pop rax
	mov rdx, 0
	mov rbx, 2
	idiv rbx
	push rax

	; End of script
	call _printInt

	; add 1
	pop rax
	add rax, 1
	push rax

	; End of script
	call _printInt


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
