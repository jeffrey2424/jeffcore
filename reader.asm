SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
SYS_OPEN  equ 5
SYS_CLOSE equ 6
STDIN     equ 0
STDOUT    equ 1

SYS_CALL  equ 0x80

section	.text
   global _start         ;must be declared for using gcc
	
_start:
	mov eax, SYS_WRITE
	mov ebx, 1
	mov ecx, welcome
	mov edx, welcome_length
	int 0x80

	call func
	mov eax, SYS_EXIT
	mov ebx, 0
	int SYS_CALL



func:
	push ebp
	mov ebp, esp

	;open the file for reading
	mov eax, 5
	mov ebx, file_name
	mov ecx, 0             ;for read only access
	mov edx, 0777          ;read, write and execute by all
	int  0x80

		
	mov  [fd_in], eax

	;read from file
	mov eax, 3
	mov ebx, [fd_in]
	mov ecx, info
	mov edx, 20
	int 0x80
		
	; print the info 
	mov eax, 4
	mov ebx, 1
	mov ecx, info
	mov edx, 20
	int 0x80

	; close the file
	mov eax, 6
	mov ebx, [fd_in]
	int  0x80

	; print linebreak
	mov eax, 4
	mov ebx, 1
	mov ecx, linebreak
	mov edx, 1
	int 0x80

	mov eax, 12
	mov [counter], eax

	;print counter
	mov eax, 4
	mov ebx, 1
	mov ecx, counter
	mov edx, 100
	int 0x80


	; call looper


	mov esp, ebp
	pop ebp
	ret

looper:
	push ebp
	mov ebp, esp

	;print counter
	mov eax, 4
	mov ebx, 1
	mov ecx, counter
	mov edx, 1
	int 0x80

	

	; print part of info
	mov eax, 4
	mov ebx, 1
	mov ecx, info
	add ecx, counter
	mov edx, 1
	int 0x80

	; ; print linebreak
	; mov eax, 4
	; mov ebx, 1
	; mov ecx, linebreak
	; mov edx, 1
	; int 0x80

	mov eax, counter
	inc eax
	mov [counter], eax

	mov eax, counter
	cmp eax, 6
	jl looper

	mov esp, ebp
	pop ebp
	ret

	
	








section	.data
welcome db 'Starting read process', 0x0a
welcome_length equ  $-welcome
linebreak db 0x0a

file_name db 'num_list.txt'
counter db 0


section .bss
fd_out resb 1
fd_in  resb 1
info resb 999
; counter resb 1
