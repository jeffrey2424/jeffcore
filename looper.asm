section	.text
   global _start         ;must be declared for using gcc
	
_start:                  ;tell linker entry point

    mov eax, 0
    mov [counter], eax

    call looper

    ; ; print the info 
    ; mov eax, 4
    ; mov ebx, 1
    ; mov ecx, counter
    ; mov edx, 1
    ; int 0x80

    ; print the info 
    mov eax, 4
    mov ebx, 1
    mov ecx, new_worder
    mov edx, 1
    int 0x80

    mov eax, 1
	mov ebx, 0
	int 0x80

func:
	push ebp
	mov ebp, esp
	sub esp, 3
	mov [esp], byte 'H'
	mov [esp+1], byte 'i'
	mov [esp+2], byte 0x0a
	mov eax, 4
	mov ebx, 0
	mov ecx, esp
	mov edx, 2
	int 0x80
	mov esp, ebp
	pop ebp
	ret

looper:
    push ebp
	mov ebp, esp

    ; print the info 
    mov eax, 4
    mov ebx, 1
    mov ecx, worder
    mov edx, 1
    int 0x80
    
    mov eax, [counter]
    add eax, 1
    mov [counter], eax

    cmp eax, 10
    jl looper

    ; mov ebx, 0
    ; int 0x80

    ; mov eax, 4
    ; mov ebx, 1
    ; mov ecx, [counter]
    ; mov edx, 1
    ; int 0x80
    ; print the info 
    mov eax, 4
    mov ebx, 1
    mov ecx, new_worder
    mov edx, 1
    int 0x80


    mov esp, ebp
	pop ebp
	ret


section	.data
worder db 'H'
new_worder db 'M'

section .bss
counter resb 1
