
section .bss
    digitSpace resb 100
    digitSpacePos resb 8
    negativeFlag resb 1

section .text
    global _start
 
_start:
    
	; start 200
	mov rax, 200
	push rax

	; subtract 500
	pop rax
	sub rax, 500
	push rax

	; multiply 4
	pop rax
	imul rax, 4
	push rax

	; divide 6
	pop rax
	cqo
	mov rbx, 6
	idiv rbx
	push rax

	; divide 7
	pop rax
	cqo
	mov rbx, 7
	idiv rbx
	push rax

	; divide 1
	pop rax
	cqo
	mov rbx, 1
	idiv rbx
	push rax

	; add 3
	pop rax
	add rax, 3
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
