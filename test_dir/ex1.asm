global _start

section .data
	message db "Hello World!", 0x0a
	messageLength equ $ - message


section .text
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, message
	mov edx, messageLength
	int 0x80

	; Graceful exit
	mov eax, 1
	mov ebx, 0
	int 0x80
