SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
SYS_OPEN  equ 5
SYS_CLOSE equ 6
STDIN     equ 0
STDOUT    equ 1

SYS_CALL  equ 0x80


global _start

section	.text

_start:
    mov ebx, 3  ; Start 3
    push ebx

    ; pop ebx
    ; add ebx, 2
    ; push ebx

    ; ; pop edx
    ; ; idiv ebx
    ; ; push ebx

    ; pop ebx
    ; add ebx, 17
    ; push ebx

    ; pop ebx
    ; imul ebx, 37
    ; push ebx

    ; print result to stout
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	pop ecx
	mov edx, 1
	int 0x80

    ; Graceful exit
	mov eax, 1
	mov ebx, 0
	int 0x80

