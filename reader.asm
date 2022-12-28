SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
SYS_OPEN  equ 5
STDIN     equ 0
STDOUT    equ 1

SYS_CALL  equ 0x80

section	.text
   global _start         ;must be declared for using gcc
	
_start:
	call func
	mov eax, SYS_EXIT
	mov ebx, 0
	int SYS_CALL

func:
	push ebp
	mov ebp, esp

	; Open file
	mov eax, SYS_OPEN
	mov ebx, file_name
	mov ecx, 0
	mov edx, 0777
	int SYS_CALL

	mov [fd_in], eax

	; Read file
	mov eax, SYS_READ
	mov ebx, [fd_in]
	mov ecx, info
	mov edx, 999
	int SYS_CALL

	; Print to stdout
	mov eax, SYS_WRITE
	mov ebx, 1
	mov ecx, info
	mov edx, 999
	int SYS_CALL

	mov esp, ebp
	pop ebp
	ret


section	.data
file_name db 'base_calc.jeff'


section .bss
fd_out resb 1
fd_in  resb 1
info resb  999
	
