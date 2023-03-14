section .data
	lineBreak db 0x0a
    zero db '0'

section .text
    global _start

_start:
    mov eax, 123
    call _printInt

    mov eax, 1
	int 0x80

_printInt:
    push ebp
	mov ebp, esp

    push eax

    mov eax, 4
    mov ebx, 1
    mov ecx, lineBreak
    mov edx, 1
    int 0x80

    pop eax

_printIntLoop:

    mov edx, 0
    mov ebx, 10
    idiv ebx

    add edx, 0x30

    mov ecx, edx
    mov eax, 4
    mov ebx, 1
    mov edx, 8
    int 0x80


    push edx

    mov ebx, ecx
    
    mov esp, ebp
	pop ebp
	ret
