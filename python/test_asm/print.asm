section .bss
    returnDigits resb 100
    returnDigitsPosition resb 8

section .text
    global _start

_start:
    mov eax, 1234
    call _printInt

    mov eax, 1
	mov ebx, 0
	int 0x80

_printInt:
    mov ecx, returnDigits
    mov ebx, 10
    mov [ecx], ebx
    inc ecx
    mov [returnDigitsPosition], ecx

_printIntLoop:
    mov edx, 0
    mov ebx, 10
    idiv ebx
    push eax
    add edx, 48

    mov ecx, returnDigitsPosition
    mov [ecx], dl
    inc ecx
    mov [returnDigitsPosition], ecx

    pop eax
    cmp eax, 0
    jne _printIntLoop

_printIntLoop2:
    mov ecx, [returnDigitsPosition]
 
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    syscall
 
    mov ecx, [returnDigitsPosition]
    dec ecx
    mov [returnDigitsPosition], ecx
 
    cmp ecx, returnDigits
    jge _printIntLoop2
 
    ret